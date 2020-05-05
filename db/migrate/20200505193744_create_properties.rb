class CreateProperties < ActiveRecord::Migration[5.1]
  def change
    create_table :properties do |t|
      t.string :name
      t.string :display_name
      t.string :address
      t.string :market_value
      t.string :owner_address
      t.string :state_id
      t.string :lat
      t.string :lng
      t.string :construction_type
      t.string :city
      t.timestamps
    end
  end
end
