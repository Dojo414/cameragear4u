class CreateLenses < ActiveRecord::Migration[6.0]
  def change
    create_table :lenses do |t|
      t.string :brand 
      t.string :mount
      t.string :focal_length
      t.integer :camera_bag_id
    end 
  end
end
