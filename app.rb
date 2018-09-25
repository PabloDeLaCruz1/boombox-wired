require "sinatra"
require_relative "models"
require "bundler/setup"
require "sinatra/flash"

set :sessions, true
use Rack::MethodOverride
set :port, 1337

def current_user
  if session[:user_id]
    return User.find(session[:user_id])
  end
end

get "/" do
  if session[:user_id]
    flash[:alert] = "You have been signed in"
    erb :user_profile, locals: {current_user: current_user, posts: Post.order(:created_at).all}
  else
    erb :index
  end
end

get "/signup" do
  erb :signup
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
  redirect "/"
end

post "/login" do
  user = User.find_by(email: params[:email])
  p user
  user.inspect
  puts params[:password]
  if user && user.password == params[:password]
    session[:user_id] = user.id
    erb :user_profile, locals: {current_user: current_user, posts: Post.order(:created_at).all}
  else
    flash[:error] = "Invalid email and/or password"
    redirect "/login"
  end
end

get "/login" do
  erb :index
end

get "/logout" do
  session[:user_id] = nil
  flash[:info] = "Dont forget to come back! :("
  redirect "/"
end

get "/user_profile" do
  erb :user_profile, locals: {current_user: current_user, posts: Post.order(:created_at).all}
end
get "/posts/new" do
  erb :new_post
end

get "/posts" do
  output = ""
  output += erb :posts, locals: {current_user: current_user, posts: Post.order(:created_at).all}
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

get "/delete-account" do
  @user = User.find(session[:user_id])
  @user.destroy
  if session[:user_id] != nil
    session[:user_id] = nil
  end
  redirect "/"
end
