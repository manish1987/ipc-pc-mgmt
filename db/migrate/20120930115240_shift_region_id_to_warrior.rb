class ShiftRegionIdToWarrior < ActiveRecord::Migration
  def up
    remove_column("addresses","region_id")
    add_column("warriors","region_id",:integer)
  end

  def down
    add_column("addresses","region_id",:integer)
    remove_column("warriors","region_id")
  end
end
