class BagsController < ApplicationController

    get '/bags/new' do
        @lenses = Lense.all
        @bodies = CameraBody.all  

    erb :'/bags/new'
    end

    post '/bags' do 
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

end