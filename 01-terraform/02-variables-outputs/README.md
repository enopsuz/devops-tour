# 📅 2026-10-15 — 2026-10-16: Variables, Outputs va Data Source'lar

## 1. Nima qilindi? (What was built?)

`01-intro` dagi qattiq yozilgan kod qayta ishlatiladigan, himoyalangan va muhitlarga (dev/prod) ajratiladigan kodga aylantirildi. Natija — prod arxitekturasining nusxasi: private network `10.0.0.0/16`, app-server (public + `10.0.0.3`) va faqat private IP'li db-server (`10.0.0.2`).

| Fayl | Mazmuni |
| :--- | :--- |
| `versions.tf` / `provider.tf` | provider versiyasi va sozlamasi (token faqat variable orqali) |
| `variables.tf` | `type`, `description`, `validation`, `sensitive`; server sozlamalari `object({...})` + `optional()` |
| `locals.tf` | `name_prefix`, joylashuv va tarmoq konstantalari, `common_labels` |
| `data.tf` | `data "hcloud_image"` — Ubuntu 26.04 (x86) |
| `network.tf` / `ssh.tf` / `server.tf` | network + subnet, SSH kalit (resurs sifatida), app (`count`) va db serverlar |
| `outputs.tf` | IP'lar, `network_id`, tayyor `ssh_command` |
| `dev.tfvars.example` / `prod.tfvars.example` | muhitga xos qiymatlar namunasi (secret'larsiz) |

**Ishga tushirish:**
```bash
read -rsp "Hetzner token: " TF_VAR_hcloud_token && echo && export TF_VAR_hcloud_token
cp dev.tfvars.example dev.tfvars      # qiymatlarni to'ldirish
terraform init
terraform plan  -var-file=dev.tfvars
terraform apply -var-file=dev.tfvars
$(terraform output -raw ssh_command)  # app-server'ga kirish
terraform destroy -var-file=dev.tfvars
```

**Bajarilgan tajribalar:** noto'g'ri `environment` → `plan`da xato · qiymat berish ustunligi (precedence) · `TF_VAR_` siz `plan` · `count` bilan dev/prod farqi · output orqali SSH · bastion orqali db'ga kirish (`ssh -J`).

## 2. Qanday muammolarga duch kelindi va ular qanday yechildi? (Blocker & Solution)

| Muammo | Sabab | Yechim |
| :--- | :--- | :--- |
| Token `terraform.tfvars` ga, `.example` ga esa `hcloud_token = ""` yozilgan | Secret faylda saqlangan | Token faqat `TF_VAR_hcloud_token` orqali; `.example` da faqat muhitga xos, secret bo'lmagan qiymatlar |
| Subnet `10.1.0.0/24` bilan `plan` o'tdi, `apply` yiqildi | Subnet network'ning (`10.0.0.0/16`) ichida emas | `10.0.0.0/24` |
| Variable qayta nomlangach `validate` xato berdi | `validation.condition` eski variable'ga murojaat qilgan | Validation faqat o'z variable'iga murojaat qiladi |
| `locals.project` → *"managed resource not declared"* | `locals.` maxsus prefiks emas — Terraform uni resurs deb o'qiydi | Murojaat `local.` orqali (`variable` → `var.` kabi) |
| `"$locals.project"` `validate`dan o'tdi, lekin nom noto'g'ri | `${ }` siz yozilgan matn hisoblanmaydi | `${ }`; natija `terraform console` da tekshiriladi |
| Kursdagi `data "hcloud_image"` misoli xato berdi | `name` va `with_selector` birga berib bo'lmaydi | Faqat `name` + `with_architecture` (x86 va arm image'larining nomi bir xil) |
| `apply` → `409 uniqueness_error` | Xuddi shu public kalit project'ga Console orqali qo'lda qo'shilgan edi | Qo'lda qo'shilgan kalit o'chirildi — kalitni Terraform boshqaradi (maqsad: hammasi noldan, koddan) |
| `apply` → `resource_unavailable` | `cx23` vaqtincha zaxirada yo'q edi; server `tainted` bo'lib qoldi | Qayta urinish; `tainted` resurs keyingi `apply`da almashtirildi |
| Prod `apply` qilingan papkada `plan -var-file=dev.tfvars` prod resurslarini o'chirmoqchi bo'ldi | Ikkala muhit bitta state'da — resurs state'dagi manzili bilan aniqlanadi, `-var-file` faqat qiymatlarni o'zgartiradi | **Bitta state = bitta muhit** → 08-labda `envs/dev`, `envs/prod` |
| `ssh_command` da `[1]` — `validate` o'tdi, dev'da `plan` yiqildi | dev'da `count = 1`, `[1]` mavjud emas | `[0]` — har ikkala muhitda bor |
| Variable'lar qayta nomlangach `plan` "osilib" qoldi | `.tfvars` da eski nomlar → majburiy variable so'raldi, chiqish faylga yo'naltirilgani uchun so'rov ko'rinmadi | `.tfvars` yangilandi; interaktiv bo'lmagan ishga tushirishda `-input=false` |
| `ssh -J ... root@10.0.0.2` → *REMOTE HOST IDENTIFICATION HAS CHANGED* | `known_hosts` da prod db'ning xuddi shu private IP'si saqlangan — private IP'lar global noyob emas | Lab uchun alohida `UserKnownHostsFile`; doimiy yechim — `HostKeyAlias` (05-lab) |
| db'da `apt update` ishlamadi, lekin *"All packages are up to date"* chiqdi | Public IP va NAT yo'q → internetga chiqish yo'q; `apt` eski indekslar bilan ishlagan | `Err`/`Warning` qatorlari o'qiladi; NAT — 05/06a-lab |

## 3. Asosiy tushunilgan g'oya (Core Concept / Feynman)

- **`variable` — funksiya parametri, `local` — ichki konstanta, `output` — return qiymati.** Tashqaridan o'zgarishi mumkin bo'lgan qiymat variable bo'ladi; qolgani local. Konfiguratsiya ichida qiymat output orqali emas, resurs atributidan to'g'ridan-to'g'ri olinadi.
- **`resource` — Terraform yaratadi va boshqaradi; `data` — faqat so'raydi.** Terraform faqat o'zi yaratganini o'chiradi: Terraform yaratgan SSH kalit `destroy` bilan o'chdi.
- **Qiymat berish ustunligi** (tajriba bilan tekshirilgan): `default` < `TF_VAR_` < `terraform.tfvars` < `*.auto.tfvars` < CLI (`-var`, `-var-file`). CLI flaglari bir darajada — buyruqda keyinroq yozilgani yutadi.
- **`validate` ≠ to'g'rilik.** `validate` sintaksis va murojaatlarni tekshiradi; qiymatlar, `count` indekslari, provider zaxirasi, IP to'qnashuvi — faqat `plan`/`apply` da ko'rinadi.
- **`sensitive` faqat yashiradi.** Ekranda va interaktiv kiritishda qiymat ko'rinmaydi, state'da esa ochiq qoladi.
- **`.terraform.lock.hcl` git'da turadi.** `init` ≈ `composer install`, `init -upgrade` ≈ `composer update`. Hash'lar — yuklangan provider paketining checksum'i; har bir platforma (OS + arxitektura) uchun alohida, chunki provider har platforma uchun alohida Go binary.
- **Hetzner xususiyatlari:** `network_zone` (`eu-central`) ⊃ `location` (`fsn1`); subnet mustaqil obyekt emas — ID va label'i yo'q; subnetdagi birinchi IP — gateway; SSH kalit serverga faqat yaratilish paytida qo'yiladi (ishlab turgan serverga kalit qo'shish — Ansible ishi); bo'shagan public IP boshqa serverga berilishi mumkin (→ `hcloud_primary_ip`, 07-lab).
- **`count`** bir xil nusxalar yoki "bor/yo'q" uchun; nusxalar ro'yxatga aylanadi (`[0]`, `[*]`). Har xil serverlar — alohida bloklar.

## 4. Keyingi sessiyada nima qilinadi? (Next Step)

- `03-state-backend`: remote state (Hetzner Object Storage, `use_lockfile`), `state list/show/mv/rm`, `import`, drift.
- Ochiq qolgan masalalar: prod'dagi 2 ta app server — faqat `count` tajribasi (trafikni taqsimlovchi yo'q, prod arxitekturasida 1 ta); `[*].network[*]` ichma-ich ro'yxatni tekislash; dev va prod bitta project'da bitta kalit bilan — 08-labda.
