class AddLastIDtoRegion < ActiveRecord::Migration
  def up
    add_column("regions","last_id",:integer)
  end

  def down
    remove_column("regions","last_id")
  end
end
