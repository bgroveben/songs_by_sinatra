require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/flash'
require 'slim'
require 'sass'
require 'data_mapper'
require 'pony'
require './song'
require './sinatra/auth'
require 'v8'
require 'coffee-script'

configure do
  enable :sessions
  set :username, 'frank'
  set :password, 'sinatra'
end

configure :development do
  DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")
##Code for email setup
#  set :email_address => 'smtp.gmail.com',
#    :email_user_name => 'frank',
#    :email_password => 'sinatra',
#    :email_domain => 'localhost.localdomain'
end

configure :production do
  DataMapper.setup(:default, ENV['DATABASE_URL'])
##Code for email setup
#  set :email_address => 'smtp.sendgrid.net',
#  :email_user_name => ENV['SENDGRID_USERNAME'],
#  :email_password => ENV['SENDGRID_PASSWORD'],
#  :email_domain => 'heroku.com'
end

before do
  set_title
end

helpers do
  def css(*stylesheets)
    stylesheets.map do |stylesheet|
      "<link href=\"/#{stylesheet}.css\" media=\"screen, projection\" rel=\"stylesheet\" />"
    end.join
  end

  def current?(path='/')
    (request.path==path || request.path==path+'/') ? "current" : nil
  end

  def set_title
    @title ||= "Songs By Sinatra"
  end

  def send_message
    Pony.mail(
      :from => params[:name] + "<" + params[:email] + ">",
      :to => 'franksinatra@gmail.com',
      :subject => params[:name] + " has contacted you",
      :body => params[:message],
      :port => '587',
      :via => :smtp,
      :via_options => {
        :address               => 'smtp.gmail.com',
        :port                  => '587',
        :enable_starttls_auto  => true,
        :user_name             => 'frank',
        :password              => 'sinatra',
        :authentication        => :plain,
        :domain                => 'localhost.localdomain'

      }
    )
  end
end

##Instead of route handlers below, use /sinatra/auth.rb
#get '/login' do
#  slim :login
#end

#post '/login' do
#  if params[:username] == settings.username && params[:password] == settings.password
#    session[:admin] = true
#    redirect to('/songs')
#  else
#    slim :login
#  end
#end

#get '/set/:name' do
#  session[:name] = params[:name]
#end

#get '/logout' do
#  session.clear
#  redirect to('/login')
#end

get '/get/hello' do
  "Hello #{session[:name]}"
end

get('/styles.css'){ scss :styles }

get '/' do
  slim :home
end

get '/about' do
  @title = "All About This Website"
  slim :about
end

get '/contact' do
  slim :contact
end

post '/contact' do
  send_message
  flash[:notice] = "Thanks for your message. We'll get back to you soon!"
  redirect to('/')
end

not_found do
  slim :not_found
end
