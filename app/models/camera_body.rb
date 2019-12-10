class CameraBody < ActiveRecord::Base
    belongs_to :camera_bag
    belongs_to :user 
end