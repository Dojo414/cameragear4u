class AddUserIdToTripods < ActiveRecord::Migration[6.0]
  def change
    add_column :tripods, :user_id, :integer
  end
end
