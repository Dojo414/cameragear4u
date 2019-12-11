class LensesController < ApplicationController

    get '/lens/new' do
        if !logged_in? 
            redirect '/users/login'
        end
        erb :'/lens/new'
end

    post '/lens' do 
        @lens = Lense.create(params["lens"])
        @lens.update(:user_id => session[:user_id])
        redirect "/users/#{session[:user_id]}/gear"
    end
    
    get '/lens/:id' do
        if !logged_in?
            redirect "/users/login"
        end 
        @lens = Lense.find(params[:id])
        if @lens.user_id != session[:user_id]
            redirect "/users/login"
        end
        erb :'/lens/show'
    end
        

    get '/lens/:id/edit' do 

        @lens = Lense.find(params[:id])

        erb :'/lens/edit'
    end

    patch '/lens/:id' do 
        @lens = Lense.find(params[:id])

        if !params["lens"]["brand"].empty?
            @lens.update(:brand => params["lens"]["brand"])
        end

        if !params["lens"]["mount"].empty?
            @lens.update(:mount => params["lens"]["mount"])
        end

        if !params["lens"]["focal_length"].empty?
            @lens.update(:focal_length => params["lens"]["focal_length"])
        end
        redirect "/lens/#{@lens.id}"
    end

    delete '/lens/:id' do 
        @lens = Lense.find(params[:id])
        @lens.destroy
        redirect "/users/#{session[:user_id]}/gear"
    end



end