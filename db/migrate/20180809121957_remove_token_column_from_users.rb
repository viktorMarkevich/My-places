class RemoveTokenColumnFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :token
  end
end
