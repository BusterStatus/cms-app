class UsersController < ApplicationController

    get '/' do
        erb :welcome
    end

    get '/signup' do
        if logged_in?
            redirect to "/users/#{current_user.slug}"
        else
          erb :'/users/signup'
        end
    end

    post '/signup' do
        if params[:password] == params[:password_confirmation] && params[:email] == params[:email_confirmation]
            user = User.create(name: params[:name], username: params[:username].downcase, email: params[:email].downcase, password: params[:password], password_confirmation: params[:password_confirmation])
            session[:user_id] = user.id
            redirect to "/users/#{user.slug}"
        else
            erb :'/users/signup'
        end
    end

    get '/login' do
        if logged_in?

            redirect to "/users/#{current_user.slug}"
        else
          erb :'/users/login'
        end
    end
    
    post '/login' do
        user = User.find_by(:email => params[:email])
        if user.try(:authenticate, params[:password]) 
            session[:user_id] = user.id
            redirect to "/users/#{current_user.slug}"
        else
          redirect "/login"
        end
    end

    post '/logout' do
        if logged_in?
            session.clear
            redirect to '/login'
        else
          erb :'/users/login'
        end
    end

    get '/users/:slug' do
        if logged_in?
            @user = User.find_by_slug(params[:slug])
            erb :'/users/show'
        else
            redirect to '/login'
        end
    end

end