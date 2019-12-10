class AddUserIdToLenses < ActiveRecord::Migration[6.0]
  def change
    add_column :lenses, :user_id, :integer
  end
end
