require 'sinatra'
require 'sinatra/reloader' if development?

get '/' do
  @title = "Welcome to the HomePage"
  erb :home
end

get '/about' do
  @title = "All About This Website"
  erb :about
end

get '/contact' do
  @title = "Contact Information"
  erb :contact
end

not_found do
  @title = "Oops, Not Found"
  erb :not_found
end
