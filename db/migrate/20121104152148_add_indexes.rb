class AddIndexes < ActiveRecord::Migration
  def up
    add_index("regions","code")
    add_index("regions","name")
    add_index("sessions","warrior_id")
    add_index("sessions","start")
  end

  def down
    remove_index("regions","code")
    remove_index("regions","name")
    remove_index("sessions","warrior_id")
    remove_index("sessions","start")
  end
end
