require 'sinatra'
require 'sinatra/reloader' if development?
require 'slim'
require 'sass'
require 'sqlite3'
require 'data_mapper'
require 'dm-sqlite-adapter'
require 'dm-core'
require 'dm-migrations'
require './song'

get('/styles.css'){ scss :styles }

get '/' do
  @title = "Welcome to the HomePage"
  slim :home
end

get '/about' do
  @title = "All About This Website"
  slim :about
end

get '/contact' do
  @title = "Contact Information"
  slim :contact
end

not_found do
  @title = "Oops, Not Found"
  slim :not_found
end
