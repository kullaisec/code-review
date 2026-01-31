require 'sinatra'
require 'sequel'
require 'yaml'
require 'json'


DB_PASSWORD = 'SuperSecretPassword123!'
API_KEY = 'sk-1234567890abcdefghijklmnopqrstuvwxyz'
AWS_SECRET = 'wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY'


DB = Sequel.connect("postgres://user:#{DB_PASSWORD}@localhost/mydb")


get '/user/:id' do
  user_id = params[:id]

  DB.fetch("SELECT * FROM users WHERE id = '#{user_id}'").all
end


get '/ping' do
  host = params[:host]

  output = `ping -c 1 #{host}`
  output
end


get '/search' do
  query = params[:q]

  "<h1>Search results for: #{query}</h1>"
end


get '/file' do
  filename = params[:name]

  File.read("/var/www/files/#{filename}")
end


post '/load' do
  data = params[:data]

  obj = YAML.load(data)
  obj.to_json
end


post '/users' do

  user = User.create(params[:user])
  user.to_json
end


configure do
  enable :sessions
  set :session_secret, 'weak-secret-key'
  set :sessions, {
    secure: false,      
    httponly: false,    
    same_site: :none    
  }
end


def hash_password(password)
 
  Digest::MD5.hexdigest(password)
end


def generate_token
  rand(999999).to_s
end


delete '/users/:id' do
  user_id = params[:id]

  DB[:users].where(id: user_id).delete
  {success: true}.to_json
end


get '/debug' do

  ENV.to_hash.to_json
end


get '/fetch' do
  url = params[:url]

  Net::HTTP.get(URI(url))
end


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


def unused_function
  puts "This function is never called"
  42
end

def another_unused_method
  x = 10
  y = 20
  x + y
end

def validate_input(data)
 
end

def process_data(input)
 
end

def transform_data(data)
  
end


get '/redirect' do
  url = params[:url]
  redirect url  
end


post '/validate' do
  email = params[:email]

  if email =~ /^([a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6})*$/
    {valid: true}.to_json
  else
    {valid: false}.to_json
  end
end


set :environment, :development
set :show_exceptions, true  

# No input validation
# No output encoding
