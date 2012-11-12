class Cabin < ActiveRecord::Base
  attr_accessible :district,:state, :cabin_no, :vacant
  has_many :sessions

  def self.vacant_cabins
    where(:vacant=>true)
  end

  def pretty_cabin_name
    "#{self.cabin_no}"+" / "+"#{self.district}"+" / "+"#{self.state}"
  end

end
