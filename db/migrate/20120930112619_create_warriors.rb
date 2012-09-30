class CreateWarriors < ActiveRecord::Migration
  def change
    create_table :warriors do |t|
      t.string :name
      t.string :church
      t.string :phone
      t.string :referrer
      t.string :warrior_no

      t.timestamps
    end
  end
end
