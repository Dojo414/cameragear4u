class AddUserIdToCameraBags < ActiveRecord::Migration[6.0]
  def change
    add_column :camera_bags, :user_id, :integer
  end
end
