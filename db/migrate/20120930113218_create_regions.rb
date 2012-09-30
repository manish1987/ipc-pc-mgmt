class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :name
      t.integer :code
      t.integer :count

      t.timestamps
    end
  end
end
