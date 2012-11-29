class Warrior < ActiveRecord::Base

  has_one :address
  belongs_to :region
  has_many :sessions

  accepts_nested_attributes_for :address
  attr_accessible :church, :name, :phone, :referrer, :warrior_no,:region_id, :address_attributes, :commitment

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

  def self.todays_warriors
    Warrior.select("id,name,phone").where("commitment=?",Date.today.wday+1)
  end
  def self.tomorrows_warriors
    Warrior.select("id,name,phone").where("commitment=?",(Date.today.wday+2).modulo(8))
  end
  def self.day_after_tomorrows_warriors
    Warrior.select("id,name,phone").where("commitment=?",(Date.today.wday+3).modulo(8))
  end

  #converts numeric commitment to string
  def prayer_commitment
    comm={-1 => "No Commitments",0=>"Monthly",1=>"Every Sunday",2=>"Every Monday",3=>"Every Tuesday",4=>"Every Wednesday",5=>"Every Thursday",6=>"Every Friday",7=>"Every Saturday"}
    if self.commitment.nil?
      return "No Commitments"
    else
      return comm[self.commitment]
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
