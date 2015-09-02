# encoding: utf-8
require 'sinatra'
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/quotes.db")
DataMapper.finalize
DataMapper.auto_upgrade!
get '/' do
   "Hello World! Is it me you're looking for?"
end
