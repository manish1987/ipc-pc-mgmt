class ChangeRegionCodeToInteger < ActiveRecord::Migration
  def up
    change_column("regions","code",:string,:limit=>3,:unique=>true)
  end

  def down
    change_column("regions","code",:integer)
  end
end
