class Warrior < ActiveRecord::Base

  has_one :address
  belongs_to :region
  has_many :sessions

  accepts_nested_attributes_for :address
  attr_accessible :church, :name, :phone, :referrer, :warrior_no,:region_id, :address_attributes

  before_destroy :delete_address
  after_destroy :update_region_count
  before_create :generate_warrior_no
  after_create :update_region_count

  def self.search(search)
    if search
      where('name LIKE ? OR phone LIKE ? OR church LIKE ?', "%#{search}%","%#{search}%","%#{search}%")
    else
      scoped
    end
  end

  def no_of_sessions
    self.sessions.length
  end
    def delete_address
      self.address.destroy
    end

    def generate_warrior_no
      region=self.region
      self.warrior_no="JM#{region.code}#{region.last_id+1}"
      region.last_id+=1
      region.save
    end

    def update_region_count
      self.region.update_count
    end

end
