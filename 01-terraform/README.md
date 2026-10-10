# 📦 01-Terraform: Infrastructure as Code (IaC)

> **"Ushbu infratuzilma odatiy 3-qavatli (3-tier) veb-ilova (Frontend, Backend API va PostgreSQL) arxitekturasi uchun mo'ljallangan."**

Ushbu modulda infratuzilma qadam-baqadam, deklarativ kod (HCL) orqali avtomatlashtiriladi. Har bir laboratoriya mustaqil (self-contained) bo'lib, har qanday tashqi dasturiy kodga bog'lanmagan holda ishlaydi.

---

## 🗺️ Terraform Laboratoriyalari Xaritasi

1. **`01-docker-postgres`** — Docker provayderi orqali tarmoq (`docker_network`), doimiy xotira (`docker_volume`) va PostgreSQL bazasini boshqarish.
2. **`02-variables-outputs`** — O'zgaruvchilar (`variables.tf`), maxfiy qiymatlar (`sensitive`) va chiqish qiymatlari (`outputs.tf`).
3. **`03-lifecycle-graph`** — Resurslar bog'liqlik grafigi (`depends_on`), `lifecycle` qoidalari (`prevent_destroy`, `create_before_destroy`).
4. **`04-state-backend`** — Terraform State arxitekturasi, state lock, remote backend (GCS / S3).
5. **`05-modules`** — Qayta ishlatiluvchi modullar (`modules/`), `count`, `for_each` va dinamik bloklar.
6. **`06-hetzner-cloud`** — Real bulut infratuzilmasi: Hetzner VM (`hcloud_server`), xavfsizlik devori (`hcloud_firewall`) va SSH kalitlar.

---

## ⏱️ O'rganish Qoidasi (Nana 25 + 5)
Har bir laboratoriya papkasida:
- **25 daqiqa:** Qo'lda `.tf` fayllarini yozish, sintaksisni sinash, xatolarni keltirib chiqarish va tuzatish.
- **5 daqiqa:** 4 ta standart savol asosida xulosani o'sha papkadagi `README.md`ga qayd etish.
