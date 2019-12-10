class CameraBag < ActiveRecord::Base
    belongs_to :user
    has_many :lenses
    has_many :tripods
    has_many :camera_bodys
end