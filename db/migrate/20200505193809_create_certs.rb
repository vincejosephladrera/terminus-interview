class CreateCerts < ActiveRecord::Migration[5.1]
  def change
    create_table :certs do |t|
      t.string :county_id
      t.string :value
      t.string :index_number
      t.string :bidder_id
      t.references :certs, :property, foreign_key: true
      t.timestamps
    end
  end
end
