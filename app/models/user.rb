class User < ActiveRecord::Base
    has_secure_password
    has_many :camera_bags
    has_many :camera_bodys
    has_many :lenses
    has_many :tripods 
end