class CreateCameraBags < ActiveRecord::Migration[6.0]
  def change
    create_table :camera_bags do |t|
      t.string :name
    end 
  end
end
