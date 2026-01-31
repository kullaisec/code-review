<?php
// Hard-coded secrets
define('DB_PASSWORD', 'MySuperSecretPassword123!');
define('API_SECRET', 'sk-proj-abcdef1234567890ABCDEF');
define('ENCRYPTION_KEY', 'my-secret-encryption-key-2024');
$aws_access_key = 'AKIAI44QH8DHBEXAMPLE';
$aws_secret_key = 'je7MtGbClwBF/2Zp9Utk/h3yCo8nvbEXAMPLEKEY';
$stripe_key = 'sk_live_4eC39HqLyjWDarjtT1zdp7dc';

// SQL Injection vulnerability
function getUserByUsername($username) {
    $conn = new mysqli('localhost', 'root', DB_PASSWORD, 'mydb');
    
    // Vulnerable to SQL injection
    $query = "SELECT * FROM users WHERE username = '$username'";
    $result = $conn->query($query);
    
    return $result->fetch_assoc();
}

// Command Injection
function convertImage($filename) {
    // Dangerous command execution
    $output = shell_exec("convert $filename output.jpg");
    return $output;
}

// XSS vulnerability
function displaySearchResults($searchTerm) {
    // Reflected XSS
    echo "<h1>Search results for: " . $searchTerm . "</h1>";
}

// Path Traversal
function readFile($filename) {
    // No path validation
    $filepath = "/var/www/html/files/" . $filename;
    return file_get_contents($filepath);
}

// File Upload without validation
function handleFileUpload() {
    if (isset($_FILES['upload'])) {
        $target_dir = "uploads/";
        $target_file = $target_dir . basename($_FILES["upload"]["name"]);
        
        // No file type validation
        move_uploaded_file($_FILES["upload"]["tmp_name"], $target_file);
        echo "File uploaded successfully";
    }
}

// LDAP Injection
function authenticateUser($username, $password) {
    $ldapconn = ldap_connect("ldap.example.com");
    
    // Vulnerable to LDAP injection
    $filter = "(uid=$username)";
    $sr = ldap_search($ldapconn, "dc=example,dc=com", $filter);
    $info = ldap_get_entries($ldapconn, $sr);
    
    return $info;
}

// XML External Entity (XXE) vulnerability
function parseXML($xmlData) {
    // XXE vulnerability
    $doc = new DOMDocument();
    $doc->loadXML($xmlData, LIBXML_NOENT | LIBXML_DTDLOAD);
    return $doc;
}

// Insecure deserialization
function loadUserData($serializedData) {
    // Dangerous unserialize
    $userData = unserialize($serializedData);
    return $userData;
}

// Weak cryptography - MD5
function hashPassword($password) {
    // MD5 is broken
    return md5($password);
}

// Using deprecated functions
function getRequestData() {
    // register_globals equivalent - deprecated
    extract($_REQUEST);
    return $data;
}

// Session fixation vulnerability
function loginUser($username, $password) {
    // No session regeneration
    $_SESSION['user'] = $username;
    $_SESSION['authenticated'] = true;
}

// CSRF vulnerability - no token validation
function updateProfile() {
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $email = $_POST['email'];
        $phone = $_POST['phone'];
        
        // No CSRF token check
        updateUserProfile($_SESSION['user_id'], $email, $phone);
    }
}

// Information disclosure
function showError($error) {
    // Exposing sensitive error information
    echo "Error: " . $error->getMessage();
    echo "Stack trace: " . $error->getTraceAsString();
    echo "File: " . $error->getFile();
    echo "Database password: " . DB_PASSWORD;
}

// Insecure random number generation
function generateToken() {
    // Weak random number generator
    return md5(rand() . time());
}

// Open redirect vulnerability
function redirect() {
    $url = $_GET['redirect'];
    // No validation
    header("Location: " . $url);
    exit();
}

// Missing access control
function deleteUser($userId) {
    // No authentication or authorization check
    $conn = new mysqli('localhost', 'root', DB_PASSWORD, 'mydb');
    $query = "DELETE FROM users WHERE id = $userId";
    $conn->query($query);
}

// Eval vulnerability
function executeCode($code) {
    // Dangerous eval
    eval($code);
}

// Complex function (code smell)
function processOrderData($order, $customer, $settings, $discount, $tax, $shipping, $promo, $region, $type) {
    $total = 0;
    if ($settings['active']) {
        if ($customer['premium']) {
            if ($discount > 0) {
                if ($tax > 0) {
                    if ($shipping['express']) {
                        if ($promo != null) {
                            if ($region == 'US') {
                                if ($type == 'A') {
                                    $total = $order['amount'] * 1.5;
                                } else {
                                    $total = $order['amount'] * 1.3;
                                }
                            } else {
                                $total = $order['amount'] * 1.2;
                            }
                        } else {
                            $total = $order['amount'] * 1.1;
                        }
                    } else {
                        $total = $order['amount'];
                    }
                } else {
                    $total = $order['amount'] * 0.9;
                }
            } else {
                $total = $order['amount'] * 0.8;
            }
        } else {
            $total = $order['amount'] * 0.7;
        }
    }
    return $total;
}

// Duplicate code block 1
function calculateOrderTotal($items) {
    $total = 0;
    foreach ($items as $item) {
        $price = $item['price'];
        $quantity = $item['quantity'];
        $tax = $price * 0.1;
        $discount = isset($item['discount']) ? $item['discount'] : 0;
        $itemTotal = ($price * $quantity) + $tax - $discount;
        $total += $itemTotal;
    }
    return $total;
}

// Duplicate code block 2
function calculateCartTotal($products) {
    $total = 0;
    foreach ($products as $item) {
        $price = $item['price'];
        $quantity = $item['quantity'];
        $tax = $price * 0.1;
        $discount = isset($item['discount']) ? $item['discount'] : 0;
        $itemTotal = ($price * $quantity) + $tax - $discount;
        $total += $itemTotal;
    }
    return $total;
}

// Dead code
function unusedFunction() {
    echo "This function is never called";
    return 42;
}

function anotherUnusedFunction() {
    $x = 10;
    $y = 20;
    return $x + $y;
}

function obsoleteMethod() {
    // Old code that's no longer used
    return true;
}

// Functions without documentation
function validateInput($data) {
    // No docstring/comments
}

function processData($input) {
    // No docstring/comments
}

function transformOutput($data) {
    // No docstring/comments
}

// Insecure cookie configuration
function setUserCookie($userId) {
    // No httpOnly, no secure flag
    setcookie("user_id", $userId, time() + 3600, "/");
}

// Missing Content Security Policy
header("X-Frame-Options: ALLOW");

// Directory listing enabled (configuration issue)
// Options +Indexes in .htaccess

// Error display enabled in production
ini_set('display_errors', 1);
error_reporting(E_ALL);

?>
