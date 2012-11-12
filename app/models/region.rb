class Region < ActiveRecord::Base

  has_many :warriors
  attr_accessible :code, :count, :name, :region_type

  def update_count
    self.count=self.warriors.length
    self.save
  end

end
