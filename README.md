# 🚀 DevOps Tour — EnOps Kundaligi

> **"You're not lazy. Your learning method is broken."** — *TechWorld with Nana*
> 
> Ushbu repository — dasturiy muhandislikdan (SWE / GoLang) DevOps va Platform Engineering sari bosib o'tilayotgan amaliy yo'l, xatolar tahlili va kundalik "Learning in Public" xulosalari makonidir.

---

## 🏗️ Arxitektura Konsepsiyasi

> **"Ushbu infratuzilma odatiy 3-qavatli (3-tier) veb-ilova (Frontend, Backend API va PostgreSQL) arxitekturasi uchun mo'ljallangan."**

Infratuzilma darajalari mustaqil va bosqichma-bosqich quriladi:
1. **Lokal Sandbox (Docker):** Tarmoqlar, doimiy disklar (volumes) va ma'lumotlar bazasi (PostgreSQL).
2. **Cloud Virtual Server (Hetzner Cloud):** Virtual mashina (VM), xavfsizlik devori (Firewall) va SSH kalitlar.
3. **Cloud-Native Klaster (Kubernetes / GKE):** Ishlab chiqarish darajasidagi klaster va xizmatlar.

---

## 🎯 Asosiy Qoida: 25 + 5 Tizimi

Har bir o'rganish sessiyasi qat'iy ikkita bo'lakka bo'linadi:
1. **25 daqiqa (Qo'lda amaliyot):** Faqat terminal, kod va arxitektura. Passiv video tomosha qilish yo'q — faqat mustaqil qurish va xatolar bilan kurashish.
2. **5 daqiqa (Qayd va xulosa):** Taymer qo'yiladi va o'sha kunlik amaliy tajriba quyidagi 4 ta savol asosida qisqa hujjatlashtiriladi.

---

## 📋 Kundalik 5 Daqiqalik Shablon (Template)

Har bir mavzu yoki laboratoriya (`Lab`) papkasidagi `README.md` fayli quyidagi standart shablon asosida to'ldiriladi:

```markdown
### 📅 [Kun raqami]: [Mavzu nomi]

#### 1. Nima qildim? (What did I build?)
- [1-2 ta jumlada bugun qilingan aniq amaliy ish: qaysi resurs yoki vosita sozlandi]

#### 2. Qanday muammoga duch keldim va uni qanday yechdim? (Blocker & Solution)
- **Muammo:** [Qaysi buyruq yoki konfiguratsiya xato berdi?]
- **Sabab:** [Xatoning tub sababi nima edi?]
- **Yechim:** [Uni qanday bartaraf etdim?]

#### 3. Asosiy tushungan g'oyam (Core Concept / Feynman)
- [Ushbu tushunchani boshqalarga yoki junior dasturchiga 1 ta gap bilan qanday tushuntiraman?]

#### 4. Ertaga navbatdagi qadamim nima? (Next Step)
- [Keyingi sessiyada nima ish qilaman? Qaysi mavzudan boshlayman?]
```

---

## 💡 Namuna: 1-Kun (Docker Provayderi va PostgreSQL)

Quyida ushbu shablonning amaliy namunasi keltirilgan:

### 📅 1-Kun: Docker Provayderi va PostgreSQL Infratuzilmasi

#### 1. Nima qildim?
`kreuzwerker/docker` provayderini sozlab, Terraform orqali `docker_network`, `docker_volume` va `postgres:16-alpine` konteynerini yaratdim. `terraform init`, `plan` va `apply` zanjirini sinab ko'rdim.

#### 2. Qanday muammoga duch keldim va uni qanday yechdim?
- **Muammo:** `.terraform.lock.hcl` faylini dastlab `.gitignore`ga kiritib qo'ygan edim.
- **Sabab:** Bu fayl xuddi Go'dagi `go.sum` yoki Node'dagi `package-lock.json` kabi provayder versiyalari va xesh-summalarini qulflab turadi.
- **Yechim:** HashiCorp rasmiy tavsiyasiga binoan, jamoa a'zolari va CI/CD runner'lar bir xil provayder versiyasini yuklashi uchun `.terraform.lock.hcl`ni gitignore'dan olib tashlab, Git'ga commit qildim.

#### 3. Asosiy tushungan g'oyam:
Terraform — bu deklarativ model. Biz konteyner operatsion tizimda qanday buyruqlar bilan ko'tarilishini emas, infratuzilmaning yakuniy holati qanday bo'lishi kerakligini yozamiz. Qolgan barcha ishlarni Terraform provayder orqali o'zi avtomatlashtiradi.

#### 4. Ertaga navbatdagi qadamim:
Statik koddan dinamik kodga o'tish: `variables.tf` (parol, port, versiya) va `outputs.tf` bilan ishlash.

---

## 🗺️ Reja va Mavzular Xaritasi
- [ ] **01-terraform** — Infrastructure as Code (IaC) asoslari (Hetzner Cloud)
  - [x] `01-intro` — Hetzner Cloud: Network, Subnets va Server VM
  - [ ] `02-variables-outputs` — O'zgaruvchilar, maxfiy ma'lumotlar va chiqishlar
  - [ ] `03-lifecycle-graph` — Xavfsizlik devori (Firewall), bog'liqliklar va hayot sikli
  - [ ] `04-state-backend` — Remote State va S3/Object Storage backend
  - [ ] `05-modules` — Qayta ishlatiluvchi modullar
  - [ ] `06-cloud-init-provisioner` — Avtomatlashtirish: Docker va tizim provayding
  - [ ] `07-todo-app-infra` — Todo-App uchun to'liq Cloud Infratuzilmasi (Capstone Project)
- [ ] **02-ansible** — Configuration Management
- [ ] **03-docker** — Konteynerlash chuqur
- [ ] **04-kubernetes** — Orchestration va Klaster boshqaruvi
- [ ] **05-cicd** — GitHub Actions & GitOps

---
*Muallif: **EnOps** ([@enopsuz](https://github.com/enopsuz)) | Vebsayt: [enops.uz](https://enops.uz)*