require 'sinatra'
<<<<<<< HEAD
require 'slim'
require 'sass'
=======
require 'sinatra/reloader' if development?
require 'slim'
require 'sass'
require 'sqlite3'
require 'data_mapper'
require 'dm-sqlite-adapter'
require 'dm-core'
require 'dm-migrations'
>>>>>>> eb9492d778467b4b7b428d819c8d66f953aa4de8
require './song'

get('/styles.css'){ scss :styles }

get '/' do
<<<<<<< HEAD
=======
  @title = "Welcome to the HomePage"
>>>>>>> eb9492d778467b4b7b428d819c8d66f953aa4de8
  slim :home
end

get '/about' do
  @title = "All About This Website"
  slim :about
end

get '/contact' do
<<<<<<< HEAD
=======
  @title = "Contact Information"
>>>>>>> eb9492d778467b4b7b428d819c8d66f953aa4de8
  slim :contact
end

not_found do
<<<<<<< HEAD
  slim :not_found
end
=======
  @title = "Oops, Not Found"
  slim :not_found
end
>>>>>>> eb9492d778467b4b7b428d819c8d66f953aa4de8
