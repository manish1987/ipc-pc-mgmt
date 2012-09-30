class Warrior < ActiveRecord::Base

  has_one :address
  belongs_to :region

  attr_accessible :church, :name, :phone, :referrer, :warrior_no,:region_id
end
