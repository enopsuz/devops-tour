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

**Kundalik odat:** har kuni bitta sessiya — uzoq, vaqti-vaqti bilan bo'ladigan "marafon"lar o'rniga qisqa, lekin uzluksiz amaliyot. DevOps bilimi bir-birining ustiga quriladi, tanaffusda esa kontekst so'nadi.

1. **25 daqiqa (Qo'lda amaliyot):** Faqat terminal, kod va arxitektura. Passiv video tomosha qilinmaydi. Vaqt tugashi bilan to'xtaladi — vazifa yarmida qolsa ham.
2. **5 daqiqa (Qayd va xulosa):** Taymer qo'yiladi va sessiya quyidagi shablon bo'yicha qisqa hujjatlashtiriladi. 5 daqiqa tugashi bilan bu ham to'xtatiladi.

**Bitta sessiya = bitta kun.** Bitta laboratoriya bir necha sessiyadan iborat; sessiyalar xaritasi laboratoriya papkasidagi `ROADMAP.md`da.

### 📋 Shablon

Har sessiya laboratoriya papkasidagi `README.md`ga **yangi yozuv** sifatida qo'shiladi (jami ~6–8 qator, jadvalsiz):

````markdown
### 📅 [Sana] · Sessiya #[N] · [Mavzu]

**1. Nima qilindi?** [1–2 jumla]
```
[Dalil: 1–3 qator terminal chiqishi — token, real IP va kalitlarsiz]
```

**2. Muammo → Sabab → Yechim:** [1 qator, yoki "Yo'q"]

**3. Asosiy g'oya:** [1 jumla — junior dasturchiga qanday tushuntiriladi]

**4. Keyingi qadam:** [keyingi sessiyaning birinchi harakati]
````

### 💡 Namuna

> ### 📅 2026-01-15 · Sessiya #1 · Terraform provayderini sozlash
>
> **1. Nima qilindi?** Provayder versiyasi `required_providers`da belgilandi, `init` → `plan` → `apply` zanjiri sinab ko'rildi.
> ```
> Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
> ```
>
> **2. Muammo → Sabab → Yechim:** `.terraform.lock.hcl` `.gitignore`da edi → u `go.sum` kabi provayder versiyasi va hash'larini qulflaydi → fayl git'ga commit qilindi.
>
> **3. Asosiy g'oya:** Terraform deklarativ — buyruqlar ketma-ketligi emas, infratuzilmaning yakuniy holati yoziladi.
>
> **4. Keyingi qadam:** qattiq yozilgan qiymatlarni `variables.tf`ga chiqarish.

---
*Muallif: **EnOps** ([@enopsuz](https://github.com/enopsuz)) | Vebsayt: [enops.uz](https://enops.uz)*
