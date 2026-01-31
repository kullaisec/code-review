# Vulnerability Statistics Summary

## Repository Contents

### 📊 Overall Statistics
- **Total Files**: 26
- **Languages Covered**: 7 (Python, Node.js, PHP, Java, Ruby, Go, YAML/HCL)
- **Lines of Code**: ~2,500+
- **Total Vulnerabilities**: 150+
- **Hardcoded Secrets**: 50+
- **Vulnerable Dependencies**: 60+ packages

---

## 🔐 Secret Detection Summary

### Total Secrets: 50+

| Secret Type | Count | Locations |
|-------------|-------|-----------|
| AWS Credentials | 8 | .env, Python, Node.js, PHP, Java, Go, Dockerfile, Terraform |
| Database Passwords | 10 | All code files, .env, CI/CD |
| API Keys (Stripe, SendGrid, etc.) | 15 | .env, code files |
| OAuth Credentials | 8 | .env, workflows |
| JWT Secrets | 4 | .env, code files |
| Private Keys | 3 | .env, code comments |
| GitHub Tokens | 2 | .env, workflows |

### Secret Locations by File
```
.env                          → 35 secrets
python/app.py                 → 5 secrets
nodejs/app.js                 → 4 secrets
php/vulnerable.php            → 4 secrets
java/VulnerableApp.java       → 5 secrets
ruby/app.rb                   → 3 secrets
go/main.go                    → 6 secrets
infra/Dockerfile              → 4 secrets
infra/terraform-main.tf       → 6 secrets
.github/workflows/vulnerable-ci.yml → 4 secrets
```

---

## 🚨 OWASP Top 10 (2021) Coverage

| Category | Instances | Files Affected | Severity |
|----------|-----------|----------------|----------|
| A01: Broken Access Control | 12 | All code files | High |
| A02: Cryptographic Failures | 45 | All files | Critical |
| A03: Injection | 35 | All code files | Critical |
| A04: Insecure Design | 8 | All code files | Medium |
| A05: Security Misconfiguration | 25 | All files | High |
| A06: Vulnerable Components | 60+ | All dependency files | Critical |
| A07: Authentication Failures | 15 | All code files | High |
| A08: Data Integrity Failures | 10 | All code files | High |
| A09: Logging Failures | 8 | All code files | Medium |
| A10: SSRF | 6 | All code files | High |

### Detailed Breakdown

#### A03: Injection (35 instances)
- SQL Injection: 7 instances (Python, Node.js, PHP, Java, Ruby, Go)
- Command Injection: 7 instances (Python, Node.js, PHP, Java, Ruby, Go)
- XSS: 7 instances (All code files)
- LDAP Injection: 2 instances (PHP, Java)
- NoSQL Injection: 1 instance (Node.js)
- XXE: 2 instances (PHP, Java)
- Template Injection: 2 instances (Python, Ruby)
- Eval/Code Injection: 2 instances (PHP, Ruby)
- ReDoS: 2 instances (Node.js, Ruby)

---

## 📦 SCA - Vulnerable Dependencies

### By Language

#### Python (requirements.txt) - 15 packages
| Package | Version | Critical CVEs |
|---------|---------|---------------|
| Flask | 0.12.2 | CVE-2018-1000656 |
| Django | 1.11.0 | CVE-2019-19844 |
| PyYAML | 3.12 | CVE-2017-18342 (RCE) |
| Pillow | 5.0.0 | CVE-2019-16865 |
| requests | 2.6.0 | CVE-2018-18074 |

#### Node.js (package.json) - 20 packages
| Package | Version | Critical CVEs |
|---------|---------|---------------|
| lodash | 4.17.4 | CVE-2019-10744, CVE-2020-8203 |
| express | 4.16.0 | CVE-2022-24999 |
| axios | 0.18.0 | CVE-2020-28168 |
| handlebars | 4.0.11 | CVE-2019-19919 |

#### Java (pom.xml) - 15 packages
| Package | Version | Critical CVEs |
|---------|---------|---------------|
| log4j-core | 2.14.0 | CVE-2021-44228 (Log4Shell) |
| jackson-databind | 2.9.0 | CVE-2019-12384 |
| struts2-core | 2.3.20 | CVE-2017-5638 |
| commons-collections4 | 4.0 | CVE-2015-6420 |

#### PHP (composer.json) - 15 packages
| Package | Version | Critical CVEs |
|---------|---------|---------------|
| symfony/symfony | 2.8.0 | CVE-2019-10909 |
| laravel/framework | 5.5.0 | Multiple CVEs |
| phpmailer/phpmailer | 5.2.0 | CVE-2017-5223 |

#### Ruby (Gemfile) - 20 packages
| Package | Version | Critical CVEs |
|---------|---------|---------------|
| rails | 4.2.0 | CVE-2016-6316, CVE-2016-6317 |
| nokogiri | 1.8.0 | CVE-2019-5477 |
| devise | 3.5.0 | CVE-2019-5421 |

#### Go (go.mod) - 13 packages
| Package | Version | Critical CVEs |
|---------|---------|---------------|
| jwt-go | 3.2.0 | CVE-2020-26160 |
| containerd | 1.3.0 | CVE-2020-15157 |
| gin-gonic | 1.6.0 | Multiple CVEs |

---

## 🏗️ Infrastructure Security Issues

### Docker (Dockerfile) - 15 issues
- Running as root (2 instances)
- Hardcoded secrets in ENV variables (4 secrets)
- Using outdated base images (ubuntu:16.04)
- Using insecure curl with -k flag
- Exposing unnecessary ports (22, 3306, 5432, etc.)
- No healthcheck defined
- World-writable permissions (chmod 777)
- Not cleaning up package cache
- No USER instruction

### Kubernetes (kubernetes-deployment.yaml) - 20 issues
- Privileged containers enabled
- Running as root (runAsUser: 0)
- hostNetwork, hostPID, hostIPC enabled
- Mounting Docker socket
- Hardcoded secrets in env variables
- No resource limits
- Overly permissive RBAC (ClusterRole with *)
- Using 'latest' image tag
- No PodSecurityPolicy
- No NetworkPolicy restrictions

### Terraform (terraform-main.tf) - 25 issues
- Hardcoded AWS credentials
- S3 bucket with public-read ACL
- Security group allowing 0.0.0.0/0 on all ports
- SSH (22) and RDP (3389) open to internet
- Database publicly accessible
- No encryption at rest
- IMDSv1 enabled (SSRF vulnerable)
- Deletion protection disabled
- No CloudTrail/GuardDuty/Security Hub
- Secrets in outputs (sensitive=false)

### CI/CD Pipeline (.github/workflows/vulnerable-ci.yml) - 10 issues
- Hardcoded secrets in workflow
- Logging secrets to console
- No dependency scanning
- Executing untrusted code (curl | bash)
- No image scanning
- Overly permissive permissions
- No approval gates for production
- Uploading sensitive files as artifacts

---

## 💻 Code Quality Issues

### By Category

#### Complex Functions - 7 instances
- Deep nesting (8+ levels) in order processing functions
- High cyclomatic complexity
- Too many parameters (8-9 parameters)
- **Files**: All language files contain at least 1 complex function

#### Duplicate Code - 14 instances
- Duplicate calculation logic in pricing functions
- Copy-pasted validation code
- **Files**: Each language file has 2 duplicate code blocks

#### Dead Code - 21 instances
- Unused functions (3 per file)
- Unreachable code paths
- **Files**: All code files contain dead code

#### Missing Documentation - 21 instances
- Functions without docstrings/comments
- 3 undocumented functions per file
- **Files**: All code files

#### Anti-patterns - 15 instances
- God objects
- Magic numbers
- Tight coupling
- Resource leaks (Java)
- Ignored error handling (Go)

---

## 🎯 Severity Distribution

### Critical Severity: 15 issues
- Log4Shell (CVE-2021-44228)
- PyYAML RCE (CVE-2017-18342)
- SQL Injection (7 instances)
- Command Injection (7 instances)
- Hardcoded production AWS credentials

### High Severity: 40 issues
- XSS vulnerabilities (7 instances)
- Path Traversal (7 instances)
- SSRF (6 instances)
- Insecure Deserialization (6 instances)
- Vulnerable dependencies with High CVEs
- Infrastructure misconfigurations

### Medium Severity: 50 issues
- Weak cryptography (MD5 usage)
- Insecure random number generation
- Missing authentication
- Information disclosure
- CORS misconfigurations
- Session management issues

### Low Severity: 45 issues
- Code quality issues
- Missing documentation
- Code duplication
- Complexity issues
- Minor configuration issues

---

## 📈 Test Coverage Recommendations

### Priority 1: Critical Detection (Must Pass)
✅ Detect all 50+ hardcoded secrets  
✅ Identify Log4Shell (CVE-2021-44228)  
✅ Find all SQL injection instances (7)  
✅ Find all Command injection instances (7)  
✅ Detect PyYAML RCE vulnerability  

### Priority 2: High Value Detection (Should Pass)
✅ Identify XSS vulnerabilities (7)  
✅ Detect Path Traversal (7)  
✅ Find SSRF vulnerabilities (6)  
✅ Identify vulnerable dependencies (60+)  
✅ Detect infrastructure misconfigurations  

### Priority 3: Comprehensive Analysis (Nice to Have)
✅ Detect code quality issues  
✅ Find duplicate code blocks  
✅ Identify dead code  
✅ Flag complex functions  
✅ Note missing documentation  

---

## 🔍 File-Specific Cheat Sheet

### Quick Reference for Testing

| File | Key Vulnerabilities | Line Numbers (Approx) |
|------|---------------------|----------------------|
| `.env` | 35+ hardcoded secrets | All lines |
| `python/app.py` | SQL injection, Command injection, XSS | 19, 28, 37, 46, 54 |
| `nodejs/app.js` | NoSQL injection, Prototype pollution | 34, 90 |
| `java/pom.xml` | Log4Shell | Line 50 |
| `infra/Dockerfile` | Root user, hardcoded secrets | Lines 5, 8-11 |
| `infra/kubernetes-deployment.yaml` | Privileged containers | Lines 25-30 |
| `infra/terraform-main.tf` | Public S3, open security groups | Lines 15, 45 |

---

## 📋 Expected Test Results

A well-functioning code review AI agent should achieve:

- **Secret Detection Rate**: 95%+ (47-50 out of 50 secrets)
- **Critical Vulnerability Detection**: 100% (All OWASP Top 10 categories)
- **Dependency CVE Detection**: 90%+ (54+ out of 60 packages)
- **Infrastructure Issue Detection**: 85%+ (50+ out of 60 issues)
- **Code Quality Detection**: 75%+ (depends on sophistication)

### False Positive Tolerance
- Acceptable: <5% false positive rate
- Comments mentioning "password" should not be flagged as secrets
- Test files can be treated differently than production code

---

## 🚀 Quick Test Commands

```bash
# Clone repository
git clone <repo-url>
cd vulnerable-code-repo

# Count total files
find . -type f | wc -l

# Count secrets in .env
grep -E '(KEY|PASSWORD|SECRET|TOKEN)' .env | wc -l

# Find all SQL queries (potential injection points)
grep -r "SELECT.*FROM" --include="*.py" --include="*.js" --include="*.php"

# List all dependency files
find . -name "requirements.txt" -o -name "package.json" -o -name "pom.xml" -o -name "composer.json" -o -name "Gemfile"
```

---

**Last Updated**: 2024  
**Vulnerability Count**: Continuously growing - check individual files for latest additions
