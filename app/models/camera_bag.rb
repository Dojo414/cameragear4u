class CameraBag < ActiveRecord::Base
    belongs_to :user
    has_many :lens
    has_many :tripod
    has_many :camera_body
end