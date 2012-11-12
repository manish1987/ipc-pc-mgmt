class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.integer :warrior_id
      t.integer :cabin_id
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end
end
