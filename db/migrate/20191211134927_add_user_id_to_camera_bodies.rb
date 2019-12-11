class AddUserIdToCameraBodies < ActiveRecord::Migration[6.0]
  def change
    add_column :camera_bodies, :user_id, :integer
  end
end
