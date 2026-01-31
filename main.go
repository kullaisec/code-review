package main

import (
	"crypto/md5"
	"database/sql"
	"encoding/hex"
	"fmt"
	"html/template"
	"io/ioutil"
	"math/rand"
	"net/http"
	"os"
	"os/exec"
	"time"

	_ "github.com/go-sql-driver/mysql"
)

// Hard-coded secrets
const (
	DBPassword    = "SuperSecretPassword123!"
	APIKey        = "sk-1234567890abcdefghijklmnopqrstuvwxyz"
	AWSAccessKey  = "AKIAIOSFODNN7EXAMPLE"
	AWSSecretKey  = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
	JWTSecret     = "my-super-secret-jwt-key"
)

var db *sql.DB

func init() {
	var err error
	// Hardcoded database password
	db, err = sql.Open("mysql", "root:"+DBPassword+"@tcp(localhost:3306)/mydb")
	if err != nil {
		panic(err)
	}
}

// SQL Injection vulnerability
func getUserHandler(w http.ResponseWriter, r *http.Request) {
	username := r.URL.Query().Get("username")
	
	// Vulnerable SQL query
	query := fmt.Sprintf("SELECT * FROM users WHERE username = '%s'", username)
	rows, err := db.Query(query)
	if err != nil {
		http.Error(w, err.Error(), 500)
		return
	}
	defer rows.Close()
	
	fmt.Fprintf(w, "User data: %v", rows)
}

// Command Injection
func pingHandler(w http.ResponseWriter, r *http.Request) {
	host := r.URL.Query().Get("host")
	
	// Dangerous command execution
	cmd := exec.Command("sh", "-c", "ping -c 1 "+host)
	output, err := cmd.CombinedOutput()
	if err != nil {
		http.Error(w, err.Error(), 500)
		return
	}
	
	w.Write(output)
}

// Path Traversal
func readFileHandler(w http.ResponseWriter, r *http.Request) {
	filename := r.URL.Query().Get("file")
	
	// No path validation
	content, err := ioutil.ReadFile("/var/www/files/" + filename)
	if err != nil {
		http.Error(w, err.Error(), 500)
		return
	}
	
	w.Write(content)
}

// XSS vulnerability
func searchHandler(w http.ResponseWriter, r *http.Request) {
	query := r.URL.Query().Get("q")
	
	// Reflected XSS - no escaping
	tmpl := template.Must(template.New("search").Parse(`
		<h1>Search Results for: {{.}}</h1>
	`))
	tmpl.Execute(w, template.HTML(query))
}

// Weak cryptography - MD5
func hashPassword(password string) string {
	hasher := md5.New()
	hasher.Write([]byte(password))
	return hex.EncodeToString(hasher.Sum(nil))
}

// Insecure random number generation
func generateToken() string {
	rand.Seed(time.Now().UnixNano())
	return fmt.Sprintf("%d", rand.Intn(999999))
}

// Missing authentication
func deleteUserHandler(w http.ResponseWriter, r *http.Request) {
	userID := r.URL.Query().Get("id")
	
	// No authentication check
	query := fmt.Sprintf("DELETE FROM users WHERE id = %s", userID)
	_, err := db.Exec(query)
	if err != nil {
		http.Error(w, err.Error(), 500)
		return
	}
	
	fmt.Fprintf(w, "User deleted")
}

// Information disclosure
func debugHandler(w http.ResponseWriter, r *http.Request) {
	// Exposing environment variables
	for _, env := range os.Environ() {
		fmt.Fprintf(w, "%s\n", env)
	}
}

// SSRF vulnerability
func fetchHandler(w http.ResponseWriter, r *http.Request) {
	url := r.URL.Query().Get("url")
	
	// No URL validation
	resp, err := http.Get(url)
	if err != nil {
		http.Error(w, err.Error(), 500)
		return
	}
	defer resp.Body.Close()
	
	body, _ := ioutil.ReadAll(resp.Body)
	w.Write(body)
}

// Race condition vulnerability
var counter int

func incrementHandler(w http.ResponseWriter, r *http.Request) {
	// Not thread-safe
	counter++
	fmt.Fprintf(w, "Counter: %d", counter)
}

// Complex function (code smell)
func processOrder(amount float64, isPremium bool, hasDiscount bool, hasTax bool, 
	isExpress bool, hasPromo bool, region string, orderType string, isActive bool) float64 {
	var total float64
	if isActive {
		if isPremium {
			if hasDiscount {
				if hasTax {
					if isExpress {
						if hasPromo {
							if region == "US" {
								if orderType == "A" {
									total = amount * 1.5
								} else {
									total = amount * 1.3
								}
							} else {
								total = amount * 1.2
							}
						} else {
							total = amount * 1.1
						}
					} else {
						total = amount
					}
				} else {
					total = amount * 0.9
				}
			} else {
				total = amount * 0.8
			}
		} else {
			total = amount * 0.7
		}
	}
	return total
}

// Duplicate code block 1
func calculateTotal(items []map[string]float64) float64 {
	total := 0.0
	for _, item := range items {
		price := item["price"]
		quantity := item["quantity"]
		tax := price * 0.1
		discount := item["discount"]
		itemTotal := (price * quantity) + tax - discount
		total += itemTotal
	}
	return total
}

// Duplicate code block 2
func calculatePrice(products []map[string]float64) float64 {
	total := 0.0
	for _, item := range products {
		price := item["price"]
		quantity := item["quantity"]
		tax := price * 0.1
		discount := item["discount"]
		itemTotal := (price * quantity) + tax - discount
		total += itemTotal
	}
	return total
}

// Dead code
func unusedFunction() {
	fmt.Println("This function is never called")
}

func anotherUnusedFunction() int {
	x := 10
	y := 20
	return x + y
}

// Functions without documentation
func validateInput(data string) bool {
	return true
}

func processData(input string) string {
	return input
}

func transformData(data string) string {
	return data
}

// Missing error handling
func riskyOperation() {
	file, _ := os.Open("data.txt") // Ignoring error
	defer file.Close()
	// ... rest of code
}

func main() {
	http.HandleFunc("/user", getUserHandler)
	http.HandleFunc("/ping", pingHandler)
	http.HandleFunc("/file", readFileHandler)
	http.HandleFunc("/search", searchHandler)
	http.HandleFunc("/delete", deleteUserHandler)
	http.HandleFunc("/debug", debugHandler)
	http.HandleFunc("/fetch", fetchHandler)
	http.HandleFunc("/increment", incrementHandler)
	
	// Running server without TLS
	fmt.Println("Server starting on :8080")
	http.ListenAndServe(":8080", nil) // No TLS, ignoring error
}
