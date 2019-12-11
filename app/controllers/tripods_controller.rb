class TripodsController < ApplicationController

    get '/tripods/new' do
        if !logged_in? 
            redirect '/users/login'
        end
        erb :'/tripods/new'
end

    post '/tripods' do 
        @tripod = Tripod.create(params["tripod"])
        @tripod.update(:user_id => session[:user_id])
        redirect "/users/#{session[:user_id]}/gear"
    end
    
    get '/tripods/:id' do
        if !logged_in?
            redirect "/users/login"
        end 
        @tripod = Tripod.find(params[:id])
        if @tripod.user_id != session[:user_id]
            redirect "/users/login"
        end
        erb :'/tripods/show'
    end
        

    get '/tripods/:id/edit' do 

        @tripod = Tripod.find(params[:id])

        erb :'/tripods/edit'
    end

    patch '/tripods/:id' do 
        @tripod = Tripod.find(params[:id])

        if !params["tripod"]["name"].empty?
            @tripod.update(:name => params["tripod"]["name"])
        end

        if !params["tripod"]["brand"].empty?
            @tripod.update(:brand => params["tripod"]["brand"])
        end

        if !params["tripod"]["length"].empty?
            @tripod.update(:sensor_size => params["tripod"]["length"])
        end
        redirect "/tripod/#{@tripod.id}"
    end

    delete '/tripods/:id' do 
        @tripod = Tripod.find(params[:id])
        @tripod.destroy
        redirect "/users/#{session[:user_id]}/gear"
    end

end