class Region < ActiveRecord::Base

  has_many :warriors
  attr_accessible :code, :count, :name, :region_type
end
