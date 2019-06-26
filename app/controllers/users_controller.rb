class UsersController < ApplicationController

    get '/' do
        erb :welcome
    end

    get '/signup' do
        if logged_in?
            redirect to '/amiibos'
        else
          erb :'/users/signup'
        end
    end

    post '/signup' do
        if params[:password] == params[:confirm_password]
            user = User.create(name: params[:name], email: params[:email], password: params[:password], password_confirmation: params[:confirm_password])
            session[:user_id] = user.id
            redirect to '/amiibos'
        else
            erb :'/users/signup'
        end
    end

    get '/login' do
        if logged_in?
            redirect to '/amiibos'
        else
          erb :'/users/login'
        end
    end
    
    post '/login' do
        user = User.find_by(:email => params[:email])
 
        if User.find_by(:email => params[:email]).try(:authenticate, params[:password]) 
            session.clear
            session[:user_id] = user.id
            redirect "/amiibos"
        else
          redirect "/login"
        end
    end

    get '/logout' do
        session.clear
        redirect '/login'
    end

    post '/logout' do
        user = User.find_by(id: session[:user_id])
        if !user.nil?
            session.clear
            redirect to '/login'
        else
          erb :'/users/login'
        end
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        @amiibos = Tweet.all
        erb :'/users/show'
    end

end