class AddTotalTimeToSession < ActiveRecord::Migration
  def change
    add_column("sessions","total",:float)
  end
end
