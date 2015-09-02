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
get '/' do
   "Hello World! Is it me you're looking for?"
end
