class BagsController < ApplicationController

    get '/bags/new' do
        if !logged_in?
            redirect '/users/login'
        end
        @lenses = Lense.all
        @bodies = CameraBody.all  
        @tripods = Tripod.all
    erb :'/bags/new'
    end

    post '/bags' do 
        if !logged_in? 
            redirect '/users/login'
        end
        if params[:bag_name] == ""
            redirect '/bags/new'
        else
            @bag = CameraBag.create(:name => params[:bag_name], :user_id => session[:user_id])

            if !params["lens"]["brand"].empty?
                @lens = Lense.create(:brand => params["lens"]["brand"], 
                :camera_bag_id => @bag.id, 
                :user_id => session[:user_id],
                :mount => params["lens"]["mount"],
                :focal_length => params["lens"]["focal_length"])
            else 
                params["camera_bag"]["lens_ids"].each do |id|
                    @lens = Lense.find(id)
                    @lens.update(:camera_bag_id => @bag.id)
                end
            end

            if !params["camera_body"]["name"].empty?
                @camera_body = CameraBody.create(:name => params["camera_body"]["name"],
                :camera_bag_id => @bag.id,
                :user_id => session[:user_id])
            else 
                params["camera_bag"]["bodies_ids"].each do |id|
                    @camera_body = CameraBody.find(id)
                    @camera_body.update(:camera_bag_id => @bag.id)
                end
            end

            if !params["tripod"]["name"].empty?
                @tripod = Tripod.create(:name => params["tripod"]["name"],
                :camera_bag_id => @bag.id,
                :user_id => session[:user_id])
            else
                params["camera_bag"]["tripod_ids"].each do |id|
                    @tripod = Tripod.find(id)
                    @tripod.update(:camera_bag_id => @bag.id)
                end
            end                
            redirect "/bags/#{@bag.id}"
        end
    end

    get '/bags/:id' do 
        @bag = CameraBag.find(params[:id])
        @lenses = @bag.lenses 
        @tripods = @bag.tripods 
        @bodies = @bag.camera_bodys

        erb :"/bags/show"
    end 

    get '/bags/:id/edit' do 
        @user = User.find(session[:user_id])
        @bag = CameraBag.find(params[:id])
        @lenses = @user.lenses
        @bodies = @user.camera_bodys
        @tripods = @user.tripods

        erb :'/bags/edit'
    end

    patch '/bags/:id' do
        if !logged_in?
            redirect 'users/login'
        end 
        @bag = CameraBag.find(params[:id])

        if !params["lens"]["brand"].empty?
            @lens = Lense.create(:brand => params["lens"]["brand"], 
            :camera_bag_id => @bag.id, 
            :user_id => session[:user_id],
            :mount => params["lens"]["mount"],
            :focal_length => params["lens"]["focal_length"])
        end

        unless params["camera_bag"]["lens_ids"] == nil 
            params["camera_bag"]["lens_ids"].each do |id|
                @lens = Lense.find(id)
                @lens.update(:camera_bag_id => @bag.id)
            end
        end
        
        unless params["camera_bag"]["lens_ids"] == nil
            @bag.lenses.each do |lens|
                if !params["camera_bag"]["lens_ids"].include?(lens.id)
                    lens.update(:camera_bag_id => nil)
                end
            end
        end

        if params["camera_bag"]["lens_ids"] == nil 
            @bag.lenses.each do |lens|
                lens.update(:camera_bag_id => nil)
            end
        end
        
        if !params["camera_body"]["name"].empty?
            @camera_body = CameraBody.create(:name => params["camera_body"]["name"],
            :camera_bag_id => @bag.id,
            :user_id => session[:user_id])
        end
        

        unless params["camera_bag"]["bodies_ids"] == nil 
            params["camera_bag"]["bodies_id"].each do |id|
                @body = CameraBody.find(id)
                @body.update(:camera_bag_id => @bag.id)
            end
        end
        
        unless params["camera_bag"]["bodies_ids"] == nil
            @bag.camera_bodys.each do |body|
                if !params["camera_bag"]["bodies_ids"].include?(body.id)
                    body.update(:camera_bag_id => nil)
                end
            end
        end

        if params["camera_bag"]["bodies_ids"] == nil 
            @bag.camera_bodys.each do |body|
                body.update(:camera_bag_id => nil)
            end
        end
        
        if !params["tripod"]["name"].empty?
            @tripod = Tripod.create(:name => params["tripod"]["name"],
            :camera_bag_id => @bag.id,
            :user_id => session[:user_id])
        end
        

        unless params["camera_bag"]["tripods_ids"] == nil 
            params["camera_bag"]["tripods_id"].each do |id|
                @tripod = Tripod.find(id)
                @tripod.update(:camera_bag_id => @bag.id)
            end
        end
        
        unless params["camera_bag"]["tripods_ids"] == nil
            @bag.tripods.each do |tripod|
                if !params["camera_bag"]["tripods_ids"].include?(tripod.id)
                    tripod.update(:camera_bag_id => nil)
                end
            end
        end

        if params["camera_bag"]["tripod_ids"] == nil 
            @bag.tripods.each do |tripod|
                tripod.update(:camera_bag_id => nil)
            end
        end
        redirect "/bags/#{@bag.id}"
    end

    delete '/bags/:id' do 
        @bag = CameraBag.find(params[:id])
        @user = User.find(session[:user_id])
        @bag.destroy
        redirect "/users/#{@user.id}/bags"
    end



end