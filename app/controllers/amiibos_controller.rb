class AmiibosController < ApplicationController

    get '/amiibos' do
        if logged_in?
            erb :'amiibos/amiibos'
        else
            redirect to '/login'
        end
    end

end