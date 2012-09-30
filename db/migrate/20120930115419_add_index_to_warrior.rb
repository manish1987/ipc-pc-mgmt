class AddIndexToWarrior < ActiveRecord::Migration
  def change
    add_index("warriors","region_id")
    add_index("warriors","name")
  end
end
