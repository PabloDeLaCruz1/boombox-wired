require "sinatra"
require_relative "models"
require "bundler/setup"
require "sinatra/flash"

set :sessions, true
use Rack::MethodOverride

def current_user
  if session[:user_id]
    return User.find(session[:user_id])
  end
end

get "/" do
  if session[:user_id]
    flash[:info] = "You have been signed in"
    erb :user_profile, locals: {current_user: current_user}
  else
    erb :index
  end
end

post "/signup" do
  # creates new user
  user = User.create(
    email: params[:email],
    first_name: params[:first_name],
    last_name: params[:last_name],
    password: params[:password],
  )

  # logs user in
  session[:user_id] = user.id

  # redirects to content page
  redirect "/content"
end

post "/login" do
  user = User.find_by(email: params[:email])

  if user && user.password == params[:password]
    session[:user_id] = user.id
    redirect "/user_profile"
  else
    flash[:info] = "Invalid email and/or password"
    redirect "/login"
  end
end

get "/login" do
  erb :login
end

get "/user_profile" do
  erb :user_profile
end
get "/posts/new" do
  erb :new_post
end

get "/posts" do
  output = ""
  output += erb :new_posts
  output += erb :posts, locals: {posts: Post.order(:created_at).all}
  output
end

post "/posts" do
  Post.create(
    title: params[:title],
    content: params[:content],
    user_id: current_user.id,
  )

  redirect "/posts"
end

get "/content" do
  erb :content, locals: {users: User.all}
end

get "/account" do
  erb :account
end

delete "/account" do
  puts "something to the terminal"
end
