class CameraBodiesController < ApplicationController

    get '/bodies/new' do
        if !logged_in? 
            redirect '/users/login'
        end
        erb :'/bodies/new'
end

    post '/bodies' do 
        @body = CameraBody.create(params["body"])
        @body.update(:user_id => session[:user_id])
        redirect "/users/#{session[:user_id]}/gear"
    end
    
    get '/bodies/:id' do
        if !logged_in?
            redirect "/users/login"
        end 
        @body = CameraBody.find(params[:id])
        if @body.user_id != session[:user_id]
            redirect "/users/login"
        end
        erb :'/bodies/show'
    end
        

    get '/bodies/:id/edit' do 

        @body = CameraBody.find(params[:id])

        erb :'/bodies/edit'
    end

    patch '/bodies/:id' do 
        @body = CameraBody.find(params[:id])

        if !params["body"]["name"].empty?
            @body.update(:name => params["body"]["name"])
        end

        if !params["body"]["brand"].empty?
            @body.update(:brand => params["body"]["brand"])
        end

        if !params["body"]["sensor_size"].empty?
            @body.update(:sensor_size => params["body"]["sensor_size"])
        end
        redirect "/bodies/#{@body.id}"
    end

    delete '/bodies/:id' do 
        @body = CameraBody.find(params[:id])
        @body.destroy
        redirect "/users/#{session[:user_id]}/gear"
    end

end