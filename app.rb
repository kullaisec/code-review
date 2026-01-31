require 'sinatra'
require 'sequel'
require 'yaml'
require 'json'

# Hard-coded secrets
DB_PASSWORD = 'SuperSecretPassword123!'
API_KEY = 'sk-1234567890abcdefghijklmnopqrstuvwxyz'
AWS_SECRET = 'wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY'

# Database connection with hardcoded password
DB = Sequel.connect("postgres://user:#{DB_PASSWORD}@localhost/mydb")

# SQL Injection vulnerability
get '/user/:id' do
  user_id = params[:id]
  # Vulnerable SQL query
  DB.fetch("SELECT * FROM users WHERE id = '#{user_id}'").all
end

# Command Injection
get '/ping' do
  host = params[:host]
  # Dangerous system call
  output = `ping -c 1 #{host}`
  output
end

# XSS vulnerability
get '/search' do
  query = params[:q]
  # Reflected XSS
  "<h1>Search results for: #{query}</h1>"
end

# Path Traversal
get '/file' do
  filename = params[:name]
  # No path validation
  File.read("/var/www/files/#{filename}")
end

# Unsafe deserialization
post '/load' do
  data = params[:data]
  # Dangerous YAML deserialization
  obj = YAML.load(data)
  obj.to_json
end

# Mass assignment vulnerability
post '/users' do
  # No strong parameters
  user = User.create(params[:user])
  user.to_json
end

# Insecure session configuration
configure do
  enable :sessions
  set :session_secret, 'weak-secret-key'
  set :sessions, {
    secure: false,       # Should be true in production
    httponly: false,     # Should be true
    same_site: :none     # Vulnerable to CSRF
  }
end

# Weak password hashing
def hash_password(password)
  # MD5 is cryptographically broken
  Digest::MD5.hexdigest(password)
end

# Insecure random token
def generate_token
  rand(999999).to_s
end

# Missing authentication
delete '/users/:id' do
  user_id = params[:id]
  # No authentication check
  DB[:users].where(id: user_id).delete
  {success: true}.to_json
end

# Information disclosure
get '/debug' do
  # Exposing environment variables
  ENV.to_hash.to_json
end

# SSRF vulnerability
get '/fetch' do
  url = params[:url]
  # No URL validation
  Net::HTTP.get(URI(url))
end

# Complex function (code smell)
def process_order(order, customer, settings, discount, tax, shipping, promo, region, type)
  total = 0
  if settings[:active]
    if customer[:premium]
      if discount > 0
        if tax > 0
          if shipping[:express]
            if promo
              if region == 'US'
                if type == 'A'
                  total = order[:amount] * 1.5
                else
                  total = order[:amount] * 1.3
                end
              else
                total = order[:amount] * 1.2
              end
            else
              total = order[:amount] * 1.1
            end
          else
            total = order[:amount]
          end
        else
          total = order[:amount] * 0.9
        end
      else
        total = order[:amount] * 0.8
      end
    else
      total = order[:amount] * 0.7
    end
  end
  total
end

# Duplicate code block 1
def calculate_total(items)
  total = 0
  items.each do |item|
    price = item[:price]
    quantity = item[:quantity]
    tax = price * 0.1
    discount = item[:discount] || 0
    item_total = (price * quantity) + tax - discount
    total += item_total
  end
  total
end

# Duplicate code block 2
def calculate_price(products)
  total = 0
  products.each do |item|
    price = item[:price]
    quantity = item[:quantity]
    tax = price * 0.1
    discount = item[:discount] || 0
    item_total = (price * quantity) + tax - discount
    total += item_total
  end
  total
end

# Dead code
def unused_function
  puts "This function is never called"
  42
end

def another_unused_method
  x = 10
  y = 20
  x + y
end

# Missing documentation
def validate_input(data)
  # No documentation
end

def process_data(input)
  # No documentation
end

def transform_data(data)
  # No documentation
end

# Open redirect
get '/redirect' do
  url = params[:url]
  redirect url  # No validation
end

# Regex DoS
post '/validate' do
  email = params[:email]
  # Vulnerable regex
  if email =~ /^([a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6})*$/
    {valid: true}.to_json
  else
    {valid: false}.to_json
  end
end

# Running in development mode
set :environment, :development
set :show_exceptions, true  # Exposing stack traces

# No rate limiting
# No CSRF protection
# No input validation
# No output encoding
