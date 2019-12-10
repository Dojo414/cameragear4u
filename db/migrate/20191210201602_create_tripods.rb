class CreateTripods < ActiveRecord::Migration[6.0]
  def change
    create_table :tripods do |t|
      t.string :name
      t.string :brand
      t.string :length 
      t.integer :camera_bag_id
    end
  end
end
