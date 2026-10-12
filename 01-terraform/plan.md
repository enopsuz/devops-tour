# 📦 01-Terraform: Infrastructure as Code (IaC) — Hetzner Cloud Edition

> **"Maqsad — `todo-app` (Frontend, Backend API va PostgreSQL) uchun to'laqonli, xavfsiz va qayta ishlatiluvchi Cloud infratuzilmasini HCL orqali noldan qurish."**

Ushbu modulda infratuzilma qadam-baqadam, deklarativ kod (HCL) orqali avtomatlashtiriladi. Boshlang'ich laboratoriyalar (01–06) orqali har bir fundamental konsept puxta o'rganiladi va yakuniy 7-bosqichda barcha bilimlar birlashib, `todo-app`ning to'liq Production infratuzilmasi barpo etiladi.

---

## 🗺️ 7 Bosqichli Laboratoriyalar Xaritasi

| Bosqich | Laboratoriya | Asosiy Mavzular va Qamrov | Holat |
| :---: | :--- | :--- | :---: |
| **01** | **`01-intro`** | Hetzner Cloud provayderi (`hcloud`), Private VPC Tarmoq (`hcloud_network`), 2 ta Subnet (`10.10.0.0/24`, `10.10.1.0/24`) va birinchi Server VM (`cx33`). Gateway IP qoidasi (`10.10.0.1`). | ✅ Bajarildi |
| **02** | **`02-variables-outputs`** | Koddagi statik ma'lumotlarni parametrlarga chiqarish (`variables.tf`), Hetzner API token va maxfiylik (`sensitive = true`), `terraform.tfvars`, SSH kalitlar (`hcloud_ssh_key`) va chiqish qiymatlari (`outputs.tf`). | 🎯 Navbatda |
| **03** | **`03-lifecycle-graph`** | Xavfsizlik devori (`hcloud_firewall`), resurslar bog'liqlik grafigi (`depends_on`), doimiy xotira diskini himoyalash (`prevent_destroy = true`), yangilash strategiyalari (`create_before_destroy = true`). | ⏳ Rejada |
| **04** | **`04-state-backend`** | Terraform State arxitekturasi (`terraform.tfstate`), xavfsizlik va drift, masofaviy saqlash (S3-compatible Object Storage / MinIO) va poygalarni oldini olish uchun State Locking. | ⏳ Rejada |
| **05** | **`05-modules`** | Kodni qayta ishlatiluvchi modullarga ajratish (`modules/network`, `modules/compute`, `modules/database`), `count`, `for_each` iteratsiyalari va dinamik bloklar. | ⏳ Rejada |
| **06** | **`06-cloud-init-provisioner`** | Serverni avtomatik tayyorlash: `cloud-init` (`user_data`) orqali VM ko'tarilishi bilan unga Docker, Docker Compose, xavfsizlik paketlari va konfiguratsiyalarni o'rnatish. | ⏳ Rejada |
| **07** | **`07-todo-app-infra`** <br>*(Capstone Project)* | **Yakuniy Katta Loyiha:** Barcha o'rganilgan vositalarni birlashtirib, `todo-app` uchun to'liq infratuzilmani (Private VPC + Firewall + Doimiy Volume disk + Compute + Docker App + PostgreSQL) bitta `terraform apply` bilan ko'tarish! | 🏆 Yakuniy |

---

## 🏗️ Yakuniy Capstone Arxitekturasi (`07-todo-app-infra`)

```text
                  ┌───────────────────────────────────────────────┐
                  │           Hetzner Cloud Firewall              │
                  │   (Faqat 80/443 HTTP va SSH ochiq, DB yopiq)  │
                  └───────────────────────┬───────────────────────┘
                                          │
       ┌──────────────────────────────────┴──────────────────────────────────┐
       │              Private Network (10.10.0.0/16 VPC)                     │
       │                                                                     │
       │   ┌───────────────────────────┐   ┌─────────────────────────────┐   │
       │   │  Web & App Server         │   │  PostgreSQL Database        │   │
       │   │  (Ubuntu + Docker)        │   │  (Private Subnet 10.10.1.x) │   │
       │   │  - React Frontend (80)    │───│  - hcloud_volume (Doimiy    │   │
       │   │  - PHP Slim Backend (8000)│   │    10GB Persistent Disk)    │   │
       │   └───────────────────────────┘   └─────────────────────────────┘   │
       └─────────────────────────────────────────────────────────────────────┘
```

---

## ⏱️ O'rganish Qoidasi (Nana 25 + 5 Tizimi)

Har bir laboratoriya papkasida:
1. **25 daqiqa (Qo'lda amaliyot):** Faqat terminal, `.tf` fayllari, sintaksis, xatolarni keltirib chiqarish va bartaraf etish.
2. **5 daqiqa (Qayd va xulosa):** Taymer qo'yiladi va o'sha laboratoriya papkasidagi `README.md` fayliga 4 ta standart savol asosida xulosa yoziladi:
   - 1. *Nima qildim? (What did I build?)*
   - 2. *Qanday muammoga duch keldim va uni qanday yechdim? (Blocker & Solution)*
   - 3. *Asosiy tushungan g'oyam (Core Concept / Feynman)*
   - 4. *Ertaga navbatdagi qadamim nima? (Next Step)*
