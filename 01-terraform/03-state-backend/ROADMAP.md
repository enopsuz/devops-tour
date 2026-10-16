# 🗺️ 03-state-backend — Sessiyalar xaritasi

> **Lab maqsadi** (`plan.md`): local state remote backend'ga ko'chiriladi, state bilan ishlash buyruqlari va drift amalda o'rganiladi.
> **Lab tayyor mezoni:** local state remote'ga ko'chirilgan (`state list` o'zgarmagan); Console'dagi qo'lda o'zgarish `plan`da ko'rinadi.

## 🚦 Sessiya qoidalari

- Har sessiya — **bitta maqsad, bitta tugallangan natija**. 25 daqiqaga sig'masa, sessiya ikkiga bo'linadi.
- **25 daqiqa** — amaliyot. Tekshiruv faqat sessiya oxirida (yoki qotib qolinganda).
- **5 daqiqa** — `README.md`ga yangi yozuv: [root README'dagi shablon](../../README.md#-shablon) bo'yicha (dalil bilan, ~6–8 qator).
- Infra ko'tarilgan sessiya oxirida — `destroy` (state bucket bundan mustasno).
- Bitta labga ko'pi bilan **bitta ➕ tajriba**.

---

## Sessiya 1 — Tayyorgarlik: bucket va S3 kalitlari

**Maqsad:** remote state uchun joy tayyor, kalitlar faqat env'da.

- `02-variables-outputs` dagi kod shu papkaga ko'chiriladi (`*.tf`, `*.example`, `.terraform.lock.hcl` — state va `*.tfvars`siz).
- Hetzner Console (lab project) → Object Storage → bucket yaratiladi (`fsn1`). Bucket qo'lda yaratiladi — bootstrap muammosi: state'ni saqlaydigan joyni o'sha state boshqara olmaydi.
- Security → S3 credentials → kalit juftligi yaratiladi.
- Kalitlar `TF_VAR_hcloud_token` kabi `read -rsp` bilan env'ga beriladi (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`). Faylga yozilmaydi.

**✅ Tayyor:** bucket Console'da bor; `echo ${#AWS_SECRET_ACCESS_KEY}` — bo'sh emas; `terraform validate` o'tadi.

---

## Sessiya 2 — Local state'dan remote'ga ko'chish

**Maqsad:** state bucket'da, hech narsa yo'qolmagan.

- Avval local state'da resurslar bo'lishi uchun `apply -var-file=dev.tfvars`; `terraform state list` natijasi saqlab qo'yiladi.
- `versions.tf`ga `backend "s3"` bloki (3-dars PDF'idagi misol asosida, `use_lockfile = true`).
- `terraform init` → *"copy existing state to the new backend?"* → `yes`.
- `init` xato bersa — provider/backend hujjatidagi S3-compatible flaglar (`skip_requesting_account_id`, `skip_s3_checksum`) sinab ko'riladi.

> ⚠️ Backend bloki ichida **variable ishlatib bo'lmaydi**. Har muhit uchun boshqa `key` kerak bo'lganda nima qilinadi? (`terraform init -help` → `-backend-config`)

**✅ Tayyor:** `state list` oldingisi bilan bir xil; Console'da bucket ichida state fayli bor; lokal `terraform.tfstate` endi ishlatilmaydi.

---

## Sessiya 3 — State locking

**Maqsad:** ikki parallel ishga tushirishdan biri bloklanadi.

- 1-terminal: `terraform apply -var-file=dev.tfvars` → tasdiq so'ralganda **javob berilmaydi** (lock ushlanib turadi).
- 2-terminal: `terraform plan -var-file=dev.tfvars` → qanday xato chiqadi?
- Bucket'da lock vaqtida qanday fayl paydo bo'ladi?

**✅ Tayyor:** 2-terminalda `Error acquiring the state lock`; 1-terminal `no` bilan yopilgach lock yo'qoladi.

---

## Sessiya 4 — State'ni o'qish va resursni qayta nomlash

**Maqsad:** resurs nomi kodda o'zgartiriladi, real infra esa tegilmaydi.

- `terraform state list`, `terraform state show <resurs>` — state'da nima saqlanadi?
- Kodda resurs nomi o'zgartiriladi (masalan `lab_network` → `main`) → `plan` nima ko'rsatadi?
- `terraform state mv` bilan state moslashtiriladi → `plan`.

**✅ Tayyor:** qayta nomlashdan keyin `plan`: `No changes`.

---

## Sessiya 5 — `state rm` va `import`

**Maqsad:** state'dan "yo'qotilgan" resurs qaytarib olinadi.

- `terraform state rm` bilan bepul resurs (masalan network) state'dan olib tashlanadi → Console'da u hali bormi? `plan` nima deydi?
- `terraform import <manzil> <id>` (CLI) bilan qaytarib olinadi.

**✅ Tayyor:** `import`dan keyin `plan`: `No changes`. `state rm` ≠ `destroy` farqi README'da.

---

## Sessiya 6 — Drift va `-replace`

**Maqsad:** Console'dagi qo'lda o'zgarish Terraform'da ko'rinadi.

- Console'da network yoki server label'i qo'lda o'zgartiriladi.
- `terraform plan -refresh-only` va oddiy `plan` — farqi nimada?
- `terraform plan -replace=<resurs>` — qachon kerak bo'ladi?

**✅ Tayyor:** drift `plan`da ko'rinadi va `apply` bilan kod holatiga qaytariladi. **Lab tayyor mezoni bajarildi.**

---

## ➕ Sessiya 7 (ixtiyoriy) — `import` bloki

**Maqsad:** 5-sessiyadagi CLI `import` deklarativ usul bilan takrorlanadi.

- `import { to = ..., id = ... }` bloki → `plan` → `apply`.
- CLI usulidan farqi: qaysi biri code review va CI uchun qulayroq?

**✅ Tayyor:** `import` bloki bilan resurs state'ga qaytdi, `plan`: `No changes`.

---

## 🏁 Labni yopish

- [ ] Oxirgi `destroy`, `state list` bo'sh (bucket qoladi)
- [ ] `README.md` — sessiya yozuvlari to'liq
- [ ] `plan.md`: 03 → `✅ Bajarildi`, 04 → `🎯 Navbatda`
