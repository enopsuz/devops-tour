# 🐘 Lab 01: Docker Provayderi va PostgreSQL Infratuzilmasi

> **"Ushbu infratuzilma odatiy 3-qavatli (3-tier) veb-ilova (Frontend, Backend API va PostgreSQL) arxitekturasi uchun mo'ljallangan."**

Ushbu laboratoriyada biz `hashicorp/local` kabi o'yinchoq misollardan voz kechib, to'g'ridan-to'g'ri haqiqiy infratuzilma primitivlari bilan ishlaymiz:
- Alohida izolyatsiyalangan bridge tarmoq (`docker_network`)
- Ma'lumotlarni doimiy saqlovchi disk hajmi (`docker_volume`)
- Rasmiy `postgres:16-alpine` bazasi konteyneri (`docker_container`)

---

## 🎯 Vazifa (25 daqiqalik amaliyot)

`main.tf` faylini yaratib, quyidagi resurslarni deklarativ tarzda sozlang:
1. **Provider:** `kreuzwerker/docker` (versiya: `~> 3.0.2`)
2. **Resurslar:**
   - `docker_network` — masalan `app_net`
   - `docker_volume` — masalan `db_data`
   - `docker_image` — `postgres:16-alpine` (keep_locally: true)
   - `docker_container` — `postgres_db`:
     - Tarmoqqa ulanish
     - Volume mount qilish (`/var/lib/postgresql/data`)
     - Port forward (`5432:5432`)
     - Environment o'zgaruvchilari (`POSTGRES_DB`, `POSTGRES_USER`, `POSTGRES_PASSWORD`)

Tekshirish buyruqlari:
```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

---

## 📋 5 Daqiqalik Xulosa (Nana 25+5)

### 📅 1-Kun: Docker Provayderi va PostgreSQL

#### 1. Nima qildim? (What did I build?)
- 

#### 2. Qanday muammoga duch keldim va uni qanday yechdim? (Blocker & Solution)
- **Muammo:** 
- **Sabab:** 
- **Yechim:** 

#### 3. Asosiy tushungan g'oyam (Core Concept / Feynman)
- 

#### 4. Ertaga navbatdagi qadamim nima? (Next Step)
- 
