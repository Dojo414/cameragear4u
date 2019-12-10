class UsersController < ApplicationController

    get '/users/login' do 
        
    erb :'/users/login'
    end

    post '/login' do 
        user = User.find_by(:username => params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/camera_bags"
        else
            redirect "/signup"
        end
    end

    get "/signup" do 

        erb :'/users/signup'
    end

    post "/signup" do 
        if params[:username] == "" || params[:password] == ""
            redirect '/signup'
        else 
            @user = User.create(:username => params[:username], :password => params[:password])
            session[:user_id] = @user.id
            redirect "users/#{@user.id}"
        end
    end

    get '/users/:id' do
        if !logged_in?
            redirect '/users/login'
        end 
        @user = User.find(params[:id])
        if @user.id == session[:user_id]
        erb :'/users/show'
        else 
            redirect '/users/login'
        end
    end

    get '/users/:id/bags' do
        if !logged_in?
            redirect 'users/login'
        end
        @user = User.find(params[:id])
        if @user.id == session[:user_id]
        @bags = @user.camera_bags 
        erb :'/users/bags'
        else 
            redirect 'users/login'
        end
    end

end
