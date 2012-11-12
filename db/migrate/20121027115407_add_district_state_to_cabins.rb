class AddDistrictStateToCabins < ActiveRecord::Migration
  def change
    add_column("cabins","district",:string)
    add_column("cabins","state",:string)
    remove_column("cabins","about")
  end
end
