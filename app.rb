# encoding: utf-8
require 'sinatra'
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/quotes.db")

class Quote
  include DataMapper::Resource
  property :id, Serial
  property :created_at, DateTime
  property :updated_at, DateTime

  property :quote_text, Text, :required => true
  property :quote_author, Text, :required => true, :default => 'NULL'
end

DataMapper.finalize
DataMapper.auto_upgrade!

# redirect index to all quotes page
get '/' do
  redirect '/quotes/'
end

# get all quotes
get '/quotes/?' do
  @quotes = Quote.all(:order => :created_at.desc)
  haml :index
end
