class AddVacantToCabins < ActiveRecord::Migration
  def change
    add_column("cabins","vacant",:boolean)
  end
end
