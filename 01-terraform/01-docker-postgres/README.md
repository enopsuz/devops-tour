# 📅 #1 (2026-10-10): Docker Provayderi, PostgreSQL va Resurslar to'qnashuvi

## 1. Nima qildim? (What did I build?)
- Terraform orqali `kreuzwerker/docker` registryning `4.6.0` versiyasini sinab ko'rdim.
- Loyihaga muvoviq DB ni ko'tarib oldim. Buning uchun menga kerak bo'ldi:
  - docker_network
  - docker_volume
  - docker_image
  - va yuqoridagilarni o'zida jam qilgan docker_container

#### 2. Qanday muammoga duch keldim va uni qanday yechdim? (Blocker & Solution)
- **1-Muammo (Noto'g'ri mount yo'li):** `container_path = "/var/lib/postgres/data"` deb yozilganda, rasmiy Postgres imijida PGDATA `/var/lib/postgresql/data` bo'lganligi sababli, Docker nomsiz (anonymous) volume ochib yubordi va bizning nomli hajmimiz bo'sh qolib ketdi.
  - *Yechim:* Yo'lni `/var/lib/postgresql/data` ga to'g'irladim. Terraform buni ishlayotgan konteynerda o'zgartira olmagani uchun konteynerni o'chirib qayta qurdi (`forces replacement`).
- **2-Muammo (`in_use` timeout):** Hajmni o'chirish paytida `timeout while waiting for state to become 'removed' (last state: 'in_use')` xatosi yuz berdi.
  - *Sabab:* 5 hafta oldin yaratilgan va to'xtatilgan (`Exited`) eski konteyner ushbu volume'ni haligacha ushlab turgan ekan. Docker to'xtatilgan konteyner bog'langan volume'ni ham o'chirishga ruxsat bermaydi.
  - *Yechim:* Eski konteynerni `docker rm` bilan tozaladim va kelgusida bunday to'qnashuvlar (naming collisions) bo'lmasligi uchun resurslarga `tour-` prefiksini berdim.

#### 3. Asosiy tushungan g'oyam (Core Concept / Feynman)
- Dockerni faqatgina compose orqaligini emas terraform orqaliham ko'tarish mumkinligini bildim. Buning qanchalik best practice ekanligi vaqt o'tib ma'lum bo'ladi;
- Shuningdek network, volume kabi resurslarni yaratishda oldingi yaratilganlarni hisobga olgan holda nom berish kerakligini bilib oldim;

#### 4. Ertaga navbatdagi qadamim nima? (Next Step)
- Statik qiymatlardan parametrlarga o'tish: `variables.tf` (parol va portlarni o'zgaruvchiga chiqarish, `sensitive = true`) va `outputs.tf` (DB ulanish parametrlarini chiqarish).
