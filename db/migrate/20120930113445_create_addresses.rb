class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :warrior_id
      t.string :addr_1
      t.string :addr_2
      t.string :city
      t.string :pin_code
      t.integer :region_id
      t.string :country

      t.timestamps
    end
  end
end
