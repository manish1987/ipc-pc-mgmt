class Session < ActiveRecord::Base
  attr_accessible :cabin_id, :end, :start, :warrior_id

  belongs_to :cabin
  belongs_to :warrior
  has_one :feedback

  def self.by_warrior_date(warrior_id,date)
    sessions=Session.where(:warrior_id=>warrior_id)
    if !date.nil? && date!=''
      sessions=sessions.where("DATE(start) = ?",date)
    end
    return sessions
  end

  def self.todays_sessions(open=false)
    sessions=Session.where("DATE(start)=?",Date.today).order("start desc")
    if open==true
      sessions=sessions.where("end IS NULL").order("start desc")
    end
    return sessions
  end

  def self.all_open
    sessions=Session.where("end IS NULL").order("start desc")
  end

  def self.total_sessions
    total_sessions=Session.all.length
  end

  def self.total_todays_sessions
    todays_sessions=Session.where("DATE(start)=?",Date.today).length
  end

  def self.pretty_hours(secs)
      secs.round
      hours=(secs/1.hour).floor
      mins=((secs.modulo(1.hour))/(1.minute)).round

      op=""
      if hours!=0
        op+="#{hours} H "
      end
      op+="#{mins} M"

      return op
  end

  def self.total_hours(options)
    if options[:range]==nil
      if options[:today]==true
        sessions=Session.todays_sessions
      elsif options[:today]==true || options[:today]==nil
        sessions=Session.all
      end
    else
      dates=options[:range].split("-")
      sessions=Session.where("DATE(start) >= ? AND DATE(start) <= ?",Date.parse(dates[0]).to_s,Date.parse(dates[1]).to_s)
    end

    total=0
    for s in sessions
      total+=s.total if !s.total.nil?
    end
    return Session.pretty_hours(total)
  end

  def self.sessions_month
    sessions=Session.where("DATE(start) >= ? AND DATE(start) <= ?",Date.new(Date.today.year,Date.today.month,1).to_s,Date.new(Date.today.year,Date.today.month,-1).to_s).length
  end

  def self.between_dates(range)
    if range
      dates=range.split("-")
      where("DATE(start) >= ? AND DATE(start) <= ?",Date.parse(dates[0]).to_s,Date.parse(dates[1]).to_s)
    else
      scoped
    end
  end

  def self.warriors_prayed_unique(range)
    dates=range.split("-")
    warrior_ids=Session.find_by_sql("SELECT DISTINCT(warrior_id) FROM sessions WHERE DATE(start) >= '#{Date.parse(dates[0]).to_s}' AND DATE(start) <= '#{Date.parse(dates[1]).to_s}'")
    warriors=Array.new
    for id in warrior_ids
      warriors << Warrior.select("id,name").where(:id=>id.warrior_id)
    end
    warriors
  end

  def self.generate_stats(range)
    if range.nil? || range==""
      range=Date.today.to_s(:long)+" - "+Date.today.to_s(:long)
    end
    puts "##############"
    puts range
    sessions=Session.between_dates(range)
    stats=Hash.new
    stats[:total_sessions]=sessions.length
    stats[:total_hours]=Session.total_hours({:range=>range})
    stats[:warriors]=Session.warriors_prayed_unique(range)
    stats[:dates_sessions]=Session.between_dates(range).count(:group=>"DATE(start)")

    stats
  end


end
