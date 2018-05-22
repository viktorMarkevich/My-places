class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.string :city
      t.datetime :date_from
      t.datetime :date_to
      t.integer :user_id

      t.timestamps
    end

    add_index :trips, :user_id
  end
end
