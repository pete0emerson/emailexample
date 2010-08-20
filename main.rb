require 'rubygems'
require 'sinatra'
require 'data_mapper'
require 'date'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")

class Email
  include DataMapper::Resource  
  property :id, Serial
  property :name, String
  property :submitted, DateTime
end

get '/' do
  erb :index
end

post '/' do
  date = DateTime.now
  email = Email.new(:name => params[:email], :submitted => date)
  if email.save
    status 201
    redirect '/'
  else
    status 312
    redirect '/'
  end
end

get '/all' do
  @emails = Email.all
  erb :show
end

DataMapper.auto_upgrade!
