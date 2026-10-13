# 1. (2026-10-12): Terraform bilan tanishuv

# 1. Nima qilindi? (What was built?)
- Terraform orqali hetznerning [hcloud](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs) v1.70.0 registriysi orqali quyidagilarni yaratishni ko'rib chiqdim
	- `network`
	- `subnet`
	- `server`

# 2. Qanday muammoga duch kelindi va u qanday yechildi? (Blocker & Solution)
## 1-muammo.  Server uchun noto'g'ri IP manzil. 
**Muammo**: Hetznerda subnetdagi birinchi IP manzil gateway'ning o'zi uchun band qilinar ekan. `10.10.0.0/24` subnetida `10.10.0.1` gatewayning o'ziga tegishli bo'larkan. Men esa bilmasdan `10.10.0.1` manzilini serverga berib qo'ygan edim, shu sababli `ip_not_available` xatoligini oldim.
**Yechim**: Serverning IP manzilini `10.10.0.2` ga o'zgartirdim. 

# 3. Asosiy tushunilgan g'oya (Core Concept / Feynman)
- Providerdagi resurslarni saytning o'zidan boshqarmasdan `terraform` bilan buni samarali tashkil qilish mumkin ekan. Ba'zida provider saytida `not available` holatida turgan serverlarni `terraform` bilan `apply` qilinsa olish imkoni bor ekan.

#### 4. Keyingi sessiyada nima qilinadi? (Next Step)
- Hozirgi holatda hetzner uchun berilgan secret token shunchaki yozilgan keyingi mavzuda aynan mana shunday o'zgaruvchilar va secret keylarni qanday boshqarishni o'rganaman.