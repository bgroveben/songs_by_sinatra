require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/flash'
require 'slim'
require 'sass'
require 'data_mapper'
require 'pony'
require './song'

configure :development do
  DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")
end

configure :production do
  DataMapper.setup(:default, ENV['DATABASE_URL'])
end

configure do
  enable :sessions
  set :username, 'frank'
  set :password, 'sinatra'
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

      })
  end
end

get '/login' do
  slim :login
end

post '/login' do
  if params[:username] == settings.username && params[:password] == settings.password
    session[:admin] = true
    redirect to('/songs')
  else
    slim :login
  end
end

get('/styles.css'){ scss :styles }

get '/set/:name' do
  session[:name] = params[:name]
end

get '/get/hello' do
  "Hello #{session[:name]}"
end

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

get '/logout' do
  session.clear
  redirect to('/login')
end
