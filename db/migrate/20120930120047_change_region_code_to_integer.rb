class ChangeRegionCodeToInteger < ActiveRecord::Migration
  def up
    change_column("regions","code",:string,:limit=>3)
  end

  def down
    change_colum("regions","code",:integer)
  end
end
