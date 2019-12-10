class User < ActiveRecord::Base
    has_secure_password
    has_many :camera_bags
    has_many :lens, through: :camera_bag
    has_many :tripod, through: :camera_bag
    has_many :camera_body, through: :camera_bag 
end