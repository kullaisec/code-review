module vulnerable-go-app

go 1.16

require (
	github.com/go-sql-driver/mysql v1.5.0 // CVE-2020-29652
	github.com/gorilla/mux v1.7.0 // Outdated
	github.com/dgrijalva/jwt-go v3.2.0+incompatible // CVE-2020-26160
	github.com/gin-gonic/gin v1.6.0 // Multiple CVEs
	github.com/labstack/echo v3.3.10+incompatible // CVE-2019-1010203
	golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2 // Outdated
	golang.org/x/net v0.0.0-20190311183353-d8887717615a // Multiple CVEs
	gopkg.in/yaml.v2 v2.2.2 // CVE-2019-11254
	github.com/prometheus/client_golang v0.9.0 // Outdated
	github.com/sirupsen/logrus v1.4.0 // Outdated
	github.com/stretchr/testify v1.3.0 // Outdated
	github.com/containerd/containerd v1.3.0 // CVE-2020-15157
	k8s.io/kubernetes v1.13.0 // Multiple CVEs
)
