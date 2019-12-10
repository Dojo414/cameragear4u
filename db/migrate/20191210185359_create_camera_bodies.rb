class CreateCameraBodies < ActiveRecord::Migration[6.0]
  def change
    create_table :camera_bodies do |t|
      t.string :name
      t.string :brand
      t.string :sensor_size
      t.integer :camera_bag_id
    end
  end
end
