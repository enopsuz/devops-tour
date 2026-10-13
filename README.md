# 🚀 DevOps Tour — EnOps Kundaligi

> **"You're not lazy. Your learning method is broken."** — *TechWorld with Nana*
>
> Ushbu repository — dasturiy muhandislikdan (SWE / GoLang) DevOps va Platform Engineering sari bosib o'tilayotgan amaliy yo'l, xatolar tahlili va kundalik "Learning in Public" xulosalari makonidir.

---

## 🏗️ Konsepsiya

Barcha modullar bitta loyiha atrofida quriladi — odatiy 3-qavatli (3-tier) veb-ilova `todo-app` (Frontend, Backend API va PostgreSQL).

Prod'da qo'lda (ClickOps) qurilgan infratuzilma har bir modulda yangi vosita bilan, sanoat standartlari asosida noldan qayta quriladi va keyingi modul oldingisining ustiga qatlam qo'shadi:

```text
Terraform (infratuzilma) → Ansible (konfiguratsiya) → Docker (konteynerlar) → Kubernetes (orkestratsiya)
  → Helm / Kustomize (paketlash) → CI/CD (avtomatlashtirish) → Monitoring & Logging (kuzatuv)
```

Har bir modul faqat o'z vositasiga e'tibor qaratadi. Boshqa vositalar o'z moduliga kelganda qo'shiladi — *YAGNI*.

---

## 🗺️ Modullar

| Modul | Mavzu | Reja | Holat |
| :--- | :--- | :--- | :---: |
| **01-terraform** | Infrastructure as Code (Hetzner Cloud) | [`plan.md`](01-terraform/plan.md) | 🎯 Jarayonda |
| **02-ansible** | Configuration Management | — | ⏳ Rejada |
| **03-docker** | Konteynerlash | — | ⏳ Rejada |
| **04-kubernetes** | Orchestration va Klaster boshqaruvi | — | ⏳ Rejada |
| **05-helm** | Kubernetes package manager | — | ⏳ Rejada |
| **06-kustomize** | Kubernetes shablonlari | — | ⏳ Rejada |
| **07-cicd** | GitHub Actions & GitOps | — | ⏳ Rejada |
| **08-monitoring-logging** | Monitoring va Logging | — | ⏳ Rejada |

Laboratoriyalar ro'yxati, qoidalar va har bir bosqichning tayyor mezoni — modulning `plan.md` faylida.

---

## ▶️ Ishga tushirish

**Talablar:**
- Terraform ≥ 1.10 (sinov: 1.16)
- Hetzner Cloud akkaunti va laboratoriyalar uchun **alohida project** (prod project'dan ajratilgan)
- Shu lab project'ining API tokeni

**Laboratoriyani ishga tushirish:**
```bash
cd 01-terraform/<laboratoriya>
export HCLOUD_TOKEN=...      # token faylga yozilmaydi
terraform init
terraform plan
terraform apply
terraform destroy            # sessiya oxirida majburiy
```

> [!WARNING]
> Hetzner Cloud — pullik xizmat. Har bir sessiya oxirida `terraform destroy` bajariladi va Console'da hech narsa qolmagani tekshiriladi.

---

## 🎯 O'rganish Usuli: 25 + 5 Tizimi

Har bir o'rganish sessiyasi qat'iy ikkita bo'lakka bo'linadi:
1. **25 daqiqa (Qo'lda amaliyot):** Faqat terminal, kod va arxitektura. Passiv video tomosha qilinmaydi — faqat mustaqil qurish va xatolar bilan kurashish.
2. **5 daqiqa (Qayd va xulosa):** Taymer qo'yiladi va sessiyadagi amaliy tajriba quyidagi 4 ta savol asosida qisqa hujjatlashtiriladi.

**25 + 5 — sessiya birligi, laboratoriya birligi emas.** Bitta laboratoriya odatda bir necha sessiya oladi.

### 📋 Shablon

Har bir laboratoriya papkasidagi `README.md` fayli quyidagi shablon asosida to'ldiriladi:

```markdown
### 📅 [Sana]: [Mavzu nomi]

#### 1. Nima qilindi? (What was built?)
- [1-2 jumlada sessiyada bajarilgan aniq amaliy ish: qaysi resurs yoki vosita sozlandi]

#### 2. Qanday muammoga duch kelindi va u qanday yechildi? (Blocker & Solution)
- **Muammo:** [Qaysi buyruq yoki konfiguratsiya xato berdi?]
- **Sabab:** [Xatoning tub sababi nima edi?]
- **Yechim:** [Xato qanday bartaraf etildi?]

#### 3. Asosiy tushunilgan g'oya (Core Concept / Feynman)
- [Tushuncha junior dasturchiga 1 ta gap bilan qanday tushuntiriladi?]

#### 4. Keyingi sessiyada nima qilinadi? (Next Step)
- [Keyingi sessiya qaysi vazifadan boshlanadi?]
```

### 💡 Namuna

Shablon qanday to'ldirilishini ko'rsatuvchi umumiy misol:

> ### 📅 2026-01-15: Terraform provayderini sozlash
>
> #### 1. Nima qilindi?
> - Terraform loyihasi yaratildi, provayder versiyasi `required_providers` blokida qat'iy belgilandi va `terraform init` → `plan` → `apply` zanjiri sinab ko'rildi.
>
> #### 2. Qanday muammoga duch kelindi va u qanday yechildi?
> - **Muammo:** `.terraform.lock.hcl` fayli dastlab `.gitignore`ga kiritilgan edi.
> - **Sabab:** Bu fayl — Go'dagi `go.sum` yoki Node'dagi `package-lock.json` kabi provayder versiyalari va xesh-summalarini qulflab turadi. Usiz har bir mashina provayderning boshqa versiyasini yuklab olishi mumkin.
> - **Yechim:** Fayl `.gitignore`dan olib tashlandi va Git'ga commit qilindi — endi barcha jamoa a'zolari va CI runner'lar bir xil provayder versiyasidan foydalanadi.
>
> #### 3. Asosiy tushunilgan g'oya
> - Terraform — deklarativ: qanday buyruqlar ketma-ketligi bajarilishi emas, infratuzilmaning yakuniy holati yoziladi. Joriy holatdan yakuniy holatga qanday yetib borishni Terraform o'zi hisoblaydi.
>
> #### 4. Keyingi sessiyada nima qilinadi?
> - Kod ichidagi statik qiymatlar `variables.tf` ga chiqariladi, natijalar `outputs.tf` orqali ko'rsatiladi.

---
*Muallif: **EnOps** ([@enopsuz](https://github.com/enopsuz)) | Vebsayt: [enops.uz](https://enops.uz)*
