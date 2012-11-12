class Address < ActiveRecord::Base
  belongs_to :warrior
  attr_accessible :addr_1, :addr_2, :city, :country, :pin_code, :warrior_id
end
