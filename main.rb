require 'sinatra'
require 'sinatra/reloader' if development?
require 'slim'

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
