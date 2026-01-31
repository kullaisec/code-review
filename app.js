const express = require('express');
const mysql = require('mysql');
const crypto = require('crypto');
const { exec } = require('child_process');
const fs = require('fs');
const path = require('path');

const app = express();
app.use(express.json());

// Hard-coded secrets
const DB_PASSWORD = 'MyDatabasePassword123!';
const JWT_SECRET = 'super-secret-jwt-key-12345';
const STRIPE_API_KEY = 'sk_live_51H1234567890abcdefghijklmnopqrstuvwxyz';
const GITHUB_TOKEN = 'ghp_1234567890abcdefGHIJKLMNOPQRSTUVWXYZ';
const SLACK_WEBHOOK = 'https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXX';

// SQL Injection vulnerability
app.get('/api/users', (req, res) => {
    const connection = mysql.createConnection({
        host: 'localhost',
        user: 'root',
        password: DB_PASSWORD,
        database: 'myapp'
    });
    
    const userId = req.query.id;
    // Vulnerable SQL query
    const query = `SELECT * FROM users WHERE id = ${userId}`;
    
    connection.query(query, (error, results) => {
        if (error) throw error;
        res.json(results);
    });
});

// Command Injection
app.post('/api/convert', (req, res) => {
    const filename = req.body.filename;
    // Dangerous command execution
    exec(`convert ${filename} output.pdf`, (error, stdout, stderr) => {
        if (error) {
            res.status(500).send(error.message);
            return;
        }
        res.send(stdout);
    });
});

// NoSQL Injection (MongoDB)
app.post('/api/login', (req, res) => {
    const { username, password } = req.body;
    // Vulnerable to NoSQL injection
    db.collection('users').findOne({
        username: username,
        password: password
    }, (err, user) => {
        if (user) {
            res.json({ success: true });
        } else {
            res.json({ success: false });
        }
    });
});

// Path Traversal
app.get('/download', (req, res) => {
    const fileName = req.query.file;
    // No path validation
    const filePath = path.join(__dirname, 'uploads', fileName);
    res.sendFile(filePath);
});

// XSS vulnerability
app.get('/search', (req, res) => {
    const searchTerm = req.query.q;
    // Reflected XSS
    res.send(`<h1>Results for: ${searchTerm}</h1>`);
});

// Weak cryptography
function hashPassword(password) {
    // MD5 is broken
    return crypto.createHash('md5').update(password).digest('hex');
}

// Insecure random token generation
function generateToken() {
    return Math.random().toString(36).substring(2);
}

// Missing rate limiting on sensitive endpoint
app.post('/api/reset-password', (req, res) => {
    const email = req.body.email;
    // No rate limiting - vulnerable to brute force
    sendPasswordResetEmail(email);
    res.json({ message: 'Reset email sent' });
});

// Prototype pollution vulnerability
app.post('/api/update-settings', (req, res) => {
    const settings = {};
    // Vulnerable to prototype pollution
    merge(settings, req.body);
    res.json(settings);
});

function merge(target, source) {
    for (let key in source) {
        if (typeof source[key] === 'object') {
            target[key] = merge(target[key] || {}, source[key]);
        } else {
            target[key] = source[key];
        }
    }
    return target;
}

// Regex DoS (ReDoS)
app.post('/validate-email', (req, res) => {
    const email = req.body.email;
    // Vulnerable regex pattern
    const emailRegex = /^([a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6})*$/;
    if (emailRegex.test(email)) {
        res.json({ valid: true });
    } else {
        res.json({ valid: false });
    }
});

// CORS misconfiguration
app.use((req, res, next) => {
    // Allows any origin
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Credentials', 'true');
    next();
});

// Missing input validation
app.post('/api/create-user', (req, res) => {
    const userData = req.body;
    // No validation of input
    database.insert(userData);
    res.json({ success: true });
});

// Complex function (code smell)
function processUserData(user, settings, options, flags, mode, context, environment, config, metadata) {
    let result;
    if (settings.active) {
        if (options.premium) {
            if (flags.verified) {
                if (mode === 'advanced') {
                    if (context.region === 'US') {
                        if (environment === 'production') {
                            if (config.level > 5) {
                                if (metadata.score > 100) {
                                    result = user.data * 1.5;
                                } else {
                                    result = user.data * 1.3;
                                }
                            } else {
                                result = user.data * 1.2;
                            }
                        } else {
                            result = user.data * 1.1;
                        }
                    } else {
                        result = user.data;
                    }
                } else {
                    result = user.data * 0.9;
                }
            } else {
                result = user.data * 0.8;
            }
        } else {
            result = user.data * 0.7;
        }
    } else {
        result = 0;
    }
    return result;
}

// Duplicate code block 1
function calculateDiscount(order) {
    let total = 0;
    for (let item of order.items) {
        const price = item.price;
        const qty = item.quantity;
        const tax = price * 0.08;
        const itemTotal = (price * qty) + tax;
        total += itemTotal;
    }
    if (total > 100) {
        total = total * 0.9;
    }
    return total;
}

// Duplicate code block 2
function calculateTotal(cart) {
    let total = 0;
    for (let item of cart.items) {
        const price = item.price;
        const qty = item.quantity;
        const tax = price * 0.08;
        const itemTotal = (price * qty) + tax;
        total += itemTotal;
    }
    if (total > 100) {
        total = total * 0.9;
    }
    return total;
}

// Dead code
function neverCalledFunction() {
    console.log('This is never executed');
    return 123;
}

function obsoleteFunction() {
    const x = 10;
    const y = 20;
    return x + y;
}

// Functions missing documentation
function processPayment(amount, currency, method) {
    // No docstring
}

function validateUser(userId) {
    // No docstring
}

function transformData(input) {
    // No docstring
}

// Insecure cookie settings
app.use(require('cookie-session')({
    name: 'session',
    keys: ['key1', 'key2'],
    secure: false,  // Should be true in production
    httpOnly: false,  // Should be true
    sameSite: 'none'  // Vulnerable to CSRF
}));

app.listen(3000, () => {
    console.log('Server running on port 3000');
    console.log(`Using API key: ${STRIPE_API_KEY}`); // Logging secrets
});
