class ChangeCabinNoType < ActiveRecord::Migration
  def up
    change_column("cabins","cabin_no",:string)
  end

  def down
    change_column("cabins","cabin_no",:integer)
  end
end
