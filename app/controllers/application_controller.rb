require './config/environment'
require 'rack-flash'
require 'rack/flash/test'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, SecureRandom.hex(64)
    use Rack::Flash
  end

  helpers do
    def logged_in?
        !!current_user
    end
      
    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def slug
      name = self.username.downcase
      split_name = name.split(" ")
      slug_name = split_name.join("-")
      slug_name
    end
    
    def self.find_by_slug(slug)
      split_slug = slug.split("-")
      deslugified_name = split_slug.each_with_index.map{|word| word}.join(" ")
      self.find_by(username: deslugified_name)
    end
  end

end