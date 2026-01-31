# Vulnerable Code Repository for Security Testing

This repository contains intentionally vulnerable code for testing security scanning tools, code review AI agents, and security analysis systems.

## ⚠️ WARNING ⚠️

**DO NOT USE THIS CODE IN PRODUCTION!**

This repository contains deliberately insecure code with multiple vulnerabilities. It is designed solely for:
- Testing security scanning tools
- Training security analysts
- Demonstrating common vulnerabilities
- Testing AI-powered code review systems

## Repository Structure

```
vulnerable-code-repo/
├── python/
│   ├── app.py                    # Flask app with OWASP Top 10 vulnerabilities
│   └── requirements.txt          # Vulnerable Python dependencies
├── nodejs/
│   ├── app.js                    # Express app with security issues
│   └── package.json              # Vulnerable Node.js dependencies
├── php/
│   ├── vulnerable.php            # PHP code with multiple vulnerabilities
│   └── composer.json             # Vulnerable PHP dependencies
├── java/
│   ├── VulnerableApp.java        # Java application with security flaws
│   └── pom.xml                   # Vulnerable Maven dependencies
├── ruby/
│   ├── app.rb                    # Sinatra app with vulnerabilities
│   └── Gemfile                   # Vulnerable Ruby gems
├── infra/
│   ├── Dockerfile                # Docker configuration with security issues
│   ├── kubernetes-deployment.yaml # Kubernetes manifest with misconfigurations
│   └── terraform-main.tf         # Terraform with infrastructure vulnerabilities
├── .github/
│   └── workflows/
│       └── vulnerable-ci.yml     # CI/CD pipeline with security issues
├── .env                          # Exposed environment variables with secrets
└── sbom.json                     # Software Bill of Materials
```

## Vulnerability Categories Covered

### 1. OWASP Top 10 (2021)

#### A01:2021 – Broken Access Control
- Missing authentication checks
- Path traversal vulnerabilities
- Insecure direct object references

#### A02:2021 – Cryptographic Failures
- Hardcoded secrets (API keys, passwords, tokens)
- Weak cryptographic algorithms (MD5, SHA1)
- Insecure random number generation
- Missing encryption at rest and in transit

#### A03:2021 – Injection
- SQL Injection
- Command Injection
- LDAP Injection
- NoSQL Injection
- XSS (Cross-Site Scripting)
- Template Injection

#### A04:2021 – Insecure Design
- Missing rate limiting
- Insufficient logging
- No security controls by design

#### A05:2021 – Security Misconfiguration
- Default credentials
- Debug mode enabled in production
- Unnecessary services exposed
- Missing security headers
- Directory listing enabled

#### A06:2021 – Vulnerable and Outdated Components
- Dependencies with known CVEs
- Outdated frameworks and libraries
- Deprecated runtime versions

#### A07:2021 – Identification and Authentication Failures
- Weak password policies
- Session fixation
- Missing session regeneration
- Insecure cookie configuration

#### A08:2021 – Software and Data Integrity Failures
- Insecure deserialization
- Unsigned/unverified packages
- CI/CD pipeline vulnerabilities

#### A09:2021 – Security Logging and Monitoring Failures
- Insufficient logging
- Logging sensitive data
- No monitoring or alerting

#### A10:2021 – Server-Side Request Forgery (SSRF)
- Unrestricted URL fetching
- No URL validation

### 2. Secret Detection Issues
- AWS credentials (Access Key, Secret Key)
- API keys (Stripe, SendGrid, Twilio, etc.)
- Database passwords
- JWT secrets
- OAuth client secrets
- Private keys
- GitHub tokens
- Slack webhooks

### 3. Infrastructure Security Issues

#### Docker
- Running as root user
- Using outdated base images
- Exposing unnecessary ports
- Hardcoded secrets in environment variables
- No health checks
- Missing security scanning

#### Kubernetes
- Privileged containers
- Running as root
- Overly permissive RBAC
- Host network/PID/IPC exposure
- Missing resource limits
- Insecure ConfigMaps
- Missing network policies

#### Terraform/IaC
- Publicly accessible resources
- Unencrypted storage
- Overly permissive security groups
- Missing logging and monitoring
- Hardcoded credentials
- No encryption at rest

### 4. Software Composition Analysis (SCA)

#### Vulnerable Dependencies
- **Python**: Flask 0.12.2, Django 1.11.0, PyYAML 3.12
- **Node.js**: lodash 4.17.4, express 4.16.0, axios 0.18.0
- **Java**: Log4j 2.14.0, Jackson 2.9.0, Struts 2.3.20
- **PHP**: Symfony 2.8.0, Laravel 5.5.0, PHPMailer 5.2.0
- **Ruby**: Rails 4.2.0, Nokogiri 1.8.0, Devise 3.5.0

### 5. Code Quality Issues

#### Anti-patterns
- God objects
- Tight coupling
- Code duplication
- Magic numbers
- Long parameter lists

#### Code Smells
- Complex functions with deep nesting
- Duplicate code blocks
- Dead code (unused functions)
- Missing documentation/docstrings
- Poor variable naming

#### Bugs
- Resource leaks
- Race conditions
- Null pointer dereferences
- Off-by-one errors

### 6. Missing Security Best Practices
- No input validation
- No output encoding
- Missing CSRF protection
- No rate limiting
- Insecure cookie settings
- Missing security headers (CSP, HSTS, X-Frame-Options)
- CORS misconfigurations

## Testing Your Code Review AI Agent

### Recommended Tests

1. **Secret Detection**
   - Scan `.env`, `app.py`, `app.js`, etc. for hardcoded credentials
   - Verify detection of various secret formats (AWS keys, API tokens, passwords)

2. **Vulnerability Detection**
   - Test for SQL injection patterns
   - Identify command injection vulnerabilities
   - Detect XSS vulnerabilities
   - Find deserialization issues

3. **Dependency Scanning (SCA)**
   - Parse `requirements.txt`, `package.json`, `pom.xml`, `composer.json`, `Gemfile`
   - Match against CVE databases
   - Identify outdated and vulnerable packages

4. **Infrastructure Security**
   - Scan Dockerfile for security issues
   - Analyze Kubernetes manifests for misconfigurations
   - Review Terraform for infrastructure vulnerabilities

5. **Code Quality**
   - Detect complex functions
   - Identify duplicate code
   - Find dead code
   - Check for missing documentation

6. **SBOM Analysis**
   - Parse `sbom.json`
   - Extract vulnerability information
   - Generate security reports

## Expected Findings Summary

- **Total Secrets**: 50+ exposed credentials
- **OWASP Top 10 Issues**: All 10 categories covered
- **Vulnerable Dependencies**: 60+ packages with known CVEs
- **Infrastructure Issues**: 30+ misconfigurations
- **Code Quality Issues**: 20+ anti-patterns and code smells
- **Critical Vulnerabilities**: 15+ (Log4Shell, SQL Injection, Command Injection, etc.)
- **High Severity Issues**: 40+
- **Medium Severity Issues**: 50+

## Usage Instructions

### Clone the Repository
```bash
git clone <your-repo-url>
cd vulnerable-code-repo
```

### Run Your Code Review AI Agent
```bash
# Example command (adjust based on your tool)
your-code-review-tool scan ./vulnerable-code-repo
```

### Expected Output
Your tool should identify and report:
1. All hardcoded secrets with their locations
2. OWASP Top 10 vulnerabilities with severity ratings
3. Vulnerable dependencies with CVE numbers
4. Infrastructure misconfigurations
5. Code quality issues and anti-patterns

## Contributing

This is a testing repository. To add new vulnerability examples:
1. Ensure the vulnerability is well-documented
2. Add comments explaining the security issue
3. Update this README with the new vulnerability type

## Disclaimer

This code is intentionally insecure and should **NEVER** be deployed to production or any public-facing environment. Use only in isolated, controlled testing environments.

## License

MIT License - For educational and testing purposes only.

## References

- [OWASP Top 10 2021](https://owasp.org/Top10/)
- [CWE Top 25](https://cwe.mitre.org/top25/)
- [CVE Database](https://cve.mitre.org/)
- [NIST NVD](https://nvd.nist.gov/)
- [SANS Top 25](https://www.sans.org/top25-software-errors/)
