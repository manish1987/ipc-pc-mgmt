class CreateCabins < ActiveRecord::Migration
  def change
    create_table :cabins do |t|
      t.integer :cabin_no
      t.text :about

      t.timestamps
    end
  end
end
