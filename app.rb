require 'sinatra'
require 'rubygems'

require './models/user'

ActiveRecord::Base.establish_connection(
    :adapter  => "mysql2",
    :host     => "127.0.0.1",
    :port     => "3306",
    :username => "taipeng",
    :password => "coen380",
    :database => "coen278"
)

class MyWebApp < Sinatra::Base
    configure do
        enable :sessions
    end

    def user_logged_in
        if session[:user]
            return true
        end
        return false
    end

    def has_notice
        if session[:notice]
            return true
        end
        return false
    end

    def init_user_info(user)
        session[:ttwin_onegame] = 0
        session[:ttloss_onegame] = 0
        session[:user] = user
    end

    def clear_user_info
        session[:user].win = session[:user].win + session[:ttwin_onegame]
        session[:user].loss = session[:user].loss + session[:ttloss_onegame]
        session[:user].save
        session.clear
    end

    get '/' do
        erb :"home/index.html"
    end

    get '/login' do
        erb :"account/login.html"
    end

    get '/register' do
        erb :"account/register.html"
    end

    get '/logout' do
        clear_user_info
        session[:notice] = "You're logged out"
        redirect '/'
    end

    get '/about' do
        erb :"home/about.html"
    end

    post '/login' do
        user = User.find_by(name: params[:username])
        if !user || user.password != params[:password]
            session[:notice] = "Username or password is incorrect!"
            redirect '/login'
        end
        init_user_info(user)
        session[:notice] = "You have logged in"
        redirect '/'
    end

    post '/register' do
        user = User.find_by(name: params[:username])
        if user
            session[:notice] = "Username already exists"
            redirect '/register'
        elsif params[:password] != params[:confirmPassword]
            session[:notice] = "Please confirm your password"
            redirect '/register'
        end
        user = User.new
        user.name = params[:username]
        user.password = params[:password]
        user.win = 0
        user.loss = 0
        user.save
        session[:notice] = "You have registered a new account"
        init_user_info(user)
        redirect '/'
    end

    post '/bet' do
        correct_number = rand(1..6)
        money = params[:betmoney].to_i
        guess = params[:betnumber].to_i
        if guess == correct_number
            session[:notice] = "You win! The number is #{guess}  :)"
            session[:ttwin_onegame] += money
            redirect '/'
        else
            session[:notice] = "You lose! The correct number is #{correct_number}, but your guess is #{guess}   :("
            session[:ttloss_onegame] += money
            redirect '/'
        end
    end
end
