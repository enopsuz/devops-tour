# 📦 01-Terraform: Infrastructure as Code (IaC) — Hetzner Cloud Edition

> **"Maqsad — prod'da qo'lda (ClickOps) qurilgan `todo-app` infratuzilmasining nusxasini (production-like replica) alohida lab project'ida faqat Terraform bilan, sanoat standartlari asosida noldan qurish."**

Avval Terraform'ning asosiy mavzulari (Asoslar, Variables, State, Modules) o'rganiladi va har biridan keyin mos laboratoriya (01–04) bajariladi. Shundan so'ng qo'shimcha laboratoriyalar (05–07) orqali bilimlar bitta bog'langan tizimga yig'iladi va 08-bosqichda `todo-app` infratuzilmasi to'liq ko'tariladi.

**Fokus:** faqat Terraform'ni chuqur o'rganish. Optimallashtirish va boshqa vositalar (Ansible, Docker, CI/CD) o'z modullarida qo'shiladi — *YAGNI*.

---

## 🚦 Qoidalar

1. **Faqat lab project:** barcha laboratoriyalar alohida Hetzner project'ida (lab) bajariladi. Prod project'ga tegilmaydi — Hetzner tokeni bitta project'ga bog'langani uchun lab tokeni prod'ga yeta olmaydi.
2. **Token faqat env orqali:** `export TF_VAR_hcloud_token=...` (`sensitive` variable orqali) yoki `export HCLOUD_TOKEN=...` (bo'sh `provider "hcloud" {}`) — faqat lab project tokeni. 08-bosqichda `export CLOUDFLARE_API_TOKEN=...` (faqat `enops.uz` zonasi uchun DNS:Edit huquqi). Token hech qachon `.tf` yoki boshqa faylga yozilmaydi. *(Istisno: `01-intro` — variables hali o'tilmagani uchun placeholder qattiq yozilgan; haqiqiy token commit qilinmaydi.)*
3. **Sessiya oxirida `terraform destroy`:** pullik bulutda hech narsa ochiq qolmaydi. Console'da tekshiriladi. (`prevent_destroy` bilan himoyalangan resurslar va state bucket bundan mustasno.)
4. **SSH faqat ruxsat etilgan IP manzildan (`/32`):** `0.0.0.0/0` ga hech qachon ochilmaydi.
5. **Har bir laboratoriya oldingisining nusxasidan boshlanadi:** `cp -r 0N-... 0N+1-...`. Har bir papka mustaqil ishlaydi, laboratoriyalar orasidagi farq `diff` bilan ko'rinadi.
6. **Mavzu chegarasi:** talab qilinadigan bilimlar — Linux, Web serverlar (Nginx), Git, Scripting (Bash). Ansible, Docker, Kubernetes, CI/CD bu modulda ishlatilmaydi — o'z vaqtida.
7. **App secret'lari Terraform'ga kirmaydi:** `sensitive = true` qiymatni faqat ekranda yashiradi — state'da u ochiq matn bo'lib qoladi. Shuning uchun DB paroli va boshqa ilova secret'lari Terraform orqali o'tkazilmaydi.
8. **`apply`dan oldin tekshiruv zanjiri:** `terraform fmt` → `validate` → `plan` chiqishi o'qiladi → shundan keyingina `apply`. `plan`da kutilmagan `destroy` yoki `replace` bo'lsa, `apply` qilinmaydi.

---

## 🗺️ 8 Bosqichli Laboratoriyalar Xaritasi

| Bosqich | Laboratoriya                             |            Asos             | Asosiy Mavzular va Qamrov                                                                                                                                                                                                                                                                                                                                                                                                                       | ✅ Tayyor mezoni                                                                                                         |    Holat    |
| :-----: | :--------------------------------------- | :-------------------------: | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------------- | :---------: |
| **01**  | **`01-intro`**                           |           Asoslar           | Hetzner Cloud provayderi (`hcloud`), Private Network (`hcloud_network`), Subnet va birinchi Server VM. Gateway IP qoidasi.                                                                                                                                                                                                                                                                                                                      | `apply` → network, subnet, server yaratiladi                                                                            | ✅ Bajarildi |
| **02**  | **`02-variables-outputs`**               |      Variables & Data       | `variables.tf`, `terraform.tfvars` (+ `.example`), `outputs.tf`, `locals` (umumiy `labels`), data source'lar (`data "hcloud_image"`), `hcloud_ssh_key`, `count`, `merge()`. Qiymat berish usullari va ustunligi (precedence): `-var`, `-var-file`, `*.auto.tfvars`, `TF_VAR_`, `default`. `validation` bloklari, `sensitive`. Qattiq yozilgan token → `sensitive` variable + `TF_VAR_hcloud_token`. ➕ Murakkab tiplar (`object`, `optional()`). | Token `.tf`da yo'q; noto'g'ri qiymat `plan` bosqichida ushlanadi                                                        | ✅ Bajarildi |
| **03**  | **`03-state-backend`**                   |            State            | State arxitekturasi, `state list` / `state show` / `state mv` / `state rm`, `refresh`, CLI orqali `terraform import`, remote backend (Hetzner Object Storage, S3-compatible, `use_lockfile`), local state'ni remote'ga ko'chirish. ➕ `import` bloki, drift (`plan -refresh-only`), `-replace`.                                                                                                                                                  | Local state remote'ga ko'chirilgan (`state list` o'zgarmagan); Console'dagi qo'lda o'zgarish `plan`da ko'rinadi         |  🎯 Navbatda   |
| **04**  | **`04-modules`**                         |           Modules           | Modullar (`modules/network`, `modules/app`, `modules/db`), `count` / `for_each` (serverlar map orqali), funksiyalar (`cidrhost()`), dynamic bloklar. ➕ `moved` bloki, modul interfeysi (inputs/outputs), `terraform test`.                                                                                                                                                                                                                      | Refactor'dan keyin `plan`: **0 to add, 0 to destroy**                                                                   |  ⏳ Rejada   |
| **05**  | **`05-firewall-nat`**                    |        ➕ Qo'shimcha         | `hcloud_firewall` (`dynamic "rule"`, joriy public IP `data "http"` orqali aniqlanadi), faqat private IP'li db-server, `hcloud_network_route` (`0.0.0.0/0` → app-server), bastion (`ssh -J`), `depends_on` (subnet → server). NAT avval **qo'lda** sozlanadi.                                                                                                                                                                                    | `ssh -J app db` ishlaydi; 22-port begona IP'dan yopiq                                                                   |  ⏳ Rejada   |
| **06a** | **`06a-cloud-init-nat`**                 |        ➕ Qo'shimcha         | `user_data` + `templatefile()`: app-server'da `ip_forward` + `MASQUERADE`, db-server'da default route. ➕ `user_data` o'zgarsa server qayta yaratiladi → `ignore_changes` / `replace_triggered_by`.                                                                                                                                                                                                                                              | db-server'da `curl ifconfig.me` → app-server IP                                                                         |  ⏳ Rejada   |
| **06b** | **`06b-cloud-init-hardening`**           |  ➕ Qo'shimcha (Linux, Web)  | db-server'da `ufw` (5432 faqat `10.0.0.3`dan, 22 faqat bastion'dan), SSH hardening (parol va root login o'chiq), `deploy` user, app-server'da Nginx (oddiy sahifa).                                                                                                                                                                                                                                                                             | `curl http://<app_ip>` ishlaydi; root SSH yopiq                                                                         |  ⏳ Rejada   |
| **07**  | **`07-stateful-resources`**              |        ➕ Qo'shimcha         | `hcloud_volume` (db-server'ga ulanadi), `hcloud_primary_ip` (app-server), `prevent_destroy`, `delete_protection`, `create_before_destroy`.                                                                                                                                                                                                                                                                                                      | Server qayta yaratilsa ham IP va volume saqlanadi                                                                       |  ⏳ Rejada   |
| **08**  | **`08-todo-app-infra`** <br>*(Capstone)* | 🏆 Yakun (+ Scripting, Web) | Bitta modullardan `envs/dev` va `envs/prod` (navbat bilan `apply`), Cloudflare provider (ikkinchi provider): `data "cloudflare_zone"` + A yozuvi (`todo.enops.uz` / `todo-dev.enops.uz`) → primary IP (`proxied = false`), Nginx'da TLS (certbot), `verify.sh` — barcha mezonlarni avtomatik tekshirish.                                                                                                                                        | Noldan `apply` → `https://todo.enops.uz` ochiladi → `verify.sh` o'tadi → ikkinchi `plan`: `No changes` → `destroy` toza | 🏆 Yakuniy  |

---

## 🏗️ Yakuniy Arxitektura (`08-todo-app-infra`)

```text
todo.enops.uz (A) ──► Hetzner Cloud Firewall (80, 443: hamma · 22: faqat ruxsat etilgan IP)
                 │   (faqat app-server'ning public interfeysiga ulanadi)
                 │
          app-server   hcloud_primary_ip + 10.0.0.3
          Nginx · NAT gateway · bastion
                 │
                 │  Private Network 10.0.0.0/16 (subnet 10.0.0.0/24)
                 │  route 0.0.0.0/0 → 10.0.0.3
                 │
          db-server    faqat 10.0.0.2 (public IP yo'q)
          ufw (5432 ← 10.0.0.3) · hcloud_volume (prevent_destroy)
```

**Muhim faktlar:**
- Subnetdagi birinchi IP (`10.0.0.1`) — network gateway, serverga berilmaydi.
- Hetzner Cloud Firewall **private network trafigini filtrlamaydi** — db-server himoyasi: public interfeys yo'qligi + `ufw`.
- Bitta network ichidagi subnetlar bir-biridan izolyatsiya qilinmaydi — subnet xavfsizlik qatlami emas.
- db-server'da default route NAT server'ga emas, **network gateway'ga (`10.0.0.1`)** yo'naltiriladi.

---

## 🚫 Ataylab tashqarida (YAGNI)

| Mavzu | Qachon |
| :--- | :--- |
| PostgreSQL o'rnatish, DB backup | Docker / Ansible modullari |
| Ansible inventory, server konfiguratsiyasi | Ansible moduli |
| Terraform CI (`fmt`, `validate`, `tflint`, `trivy`) | CI/CD moduli |
| Load Balancer | Bir nechta app-server kerak bo'lganda |
| Modul versiyalash, workspaces, `terraform_remote_state` | Kerak bo'lganda |

---

## ⏱️ O'rganish Qoidasi

25 + 5 tizimi va README shabloni — [root README](../README.md#-organish-usuli-25--5-tizimi). Bitta laboratoriya odatda bir necha sessiya oladi.
