# encoding: utf-8
require 'sinatra'
require 'data_mapper'
set :show_exceptions, :after_handler

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

# form to add a new quote
get '/quotes/new/?' do
  @title = "New Quote"
  haml :new_quote
end

# get a single quote
get '/quotes/:id/?' do |id|
  halt 400, "Please provide a numerical ID." unless id =~ /\d+/
  @quote = Quote.get!(id)
  @title = "Quote " + id
  haml :quote
end

# save a new quote
post '/quotes/?' do
  @quote = Quote.new
  @quote.created_at = Time.now
  @quote.updated_at = Time.now
  @quote.quote_text = params[:quote]
  @quote.quote_author = params[:author]

  if @quote.save
    redirect '/quotes'
  else
    "Something went wrong and your quote wasn't saved. Try again?"
  end
end

error DataMapper::ObjectNotFoundError do
  haml :not_found
end
