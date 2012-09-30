class AddRegionTypeToRegions < ActiveRecord::Migration
  def change
    add_column("regions","region_type",:string,:limit=>15)
  end
end
