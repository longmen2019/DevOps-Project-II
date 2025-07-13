
```markdown
# 🚀 Microsoft Entra ID Provisioning with Terraform

Welcome to an infrastructure-as-code solution that streamlines identity management in Microsoft Entra ID using Terraform. This project dynamically provisions users and securely assigns them to role-based groups by parsing a simple CSV file. It’s designed for scalability, automation, and elegance.

---

## 📦 Features

- ✅ Automatically create users from a `users.csv` file
- ✅ Generate unique and readable `user_principal_name` values
- ✅ Enforce initial password change for security
- ✅ Dynamically create and assign users to groups based on department and job title
- ✅ Clean separation of logic via Terraform locals and for_each constructs
- ✅ CLI-friendly output and debugging capabilities

---

## 🧠 How It Works

### 👥 User Generation
Users are sourced from `users.csv`, which includes:

```csv
first_name,last_name,department,job_title
Jim,Halpert,Education,Engineer
Pam,Beesly,Education,Engineer
Michael,Scott,Education,Manager
```

Terraform uses these entries to:
- Derive a UPN: `jhalpert@yourdomain.com`
- Create a password: `halpertj3!`
- Assign display name and metadata
- Enforce password reset at first sign-in

> Behind the scenes, Terraform uses `format()`, `substr()`, and `random_pet` to keep things clean and collision-free.

---

### 👯 Group Assignments

Terraform creates these Entra ID security groups:
- `Education Department`
- `Education - Engineers`
- `Education - Managers`
- `Education - Customer Success`

Using dynamic `for_each` with filters like `user.job_title == "Manager"`, users are slotted into the appropriate teams. All done without manual oversight.

---

## 🛠️ Getting Started

### 1️⃣ Clone & Configure
Start by cloning this repo and updating the CSV:
```bash
git clone <your-repo-url>
cd entra-id-provisioning
```

Edit `users.csv` to match your organization’s structure.

### 2️⃣ Initialize Terraform
```bash
terraform init
```

### 3️⃣ Apply in Two Phases
First, create users:
```bash
terraform apply -target=azuread_user.users
```

Then assign users to groups:
```bash
terraform apply
```

---

## 🧰 Requirements

| Tool           | Version       |
|----------------|---------------|
| Terraform      | v1.5+         |
| Azure CLI      | Latest        |
| AzureAD Provider | `>=2.0`    |
| CSV File       | UTF-8 encoded |

---

## 🧪 Verifying Success

List newly created users:
```bash
az ad user list --filter "department eq 'Education'" --query "[].{ name: displayName }" --output tsv
```

Check group memberships:
```bash
az ad group member list --group "Education - Engineers" --query "[].{ name: displayName }" --output tsv
```

---

## 📚 Reference

Inspired by the official tutorial from HashiCorp:  
🔗 [Manage Microsoft Entra ID users and groups with Terraform](https://developer.hashicorp.com/terraform/tutorials/it-saas/entra-id)

It covers the foundations and best practices for identity automation in Azure environments. This project builds on those principles with added customization and modular logic.

---

## 🔮 Future Improvements

- Role-based access control (RBAC) binding
- Onboarding workflow integration
- Error validation for CSV inputs
- SAML integration and conditional access policies

---

## 👤 Author

**Long**  
Cloud Architect | Terraform Automation Enthusiast  
Passionate about secure infrastructure, scalable deployments, and creative problem-solving  
Connect with me to collaborate on secure cloud strategies, or game dev side quests like *Terramino*


