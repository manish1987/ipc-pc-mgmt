module ApplicationHelper
    def sortable(column, title = nil, region_id=nil,tab=nil)
      title ||= column.titleize
      direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
      if direction=="desc"
        arrow="<i class='icon-chevron-up'></i>"
      else
        arrow="<i class='icon-chevron-down'></i>"
      end

      if column==sort_column
        link_title=title+" "+arrow
      else
        link_title=title
      end

      link_to raw(link_title),params.merge(:sort => column, :direction => direction, :page => nil,:tab=>tab)
    end

    def pretty_date_time(time)
#      time.strftime("%d/%m/%Y %H:%M %p")
       time.to_s(:long)
    end

    def pretty_date(time)
      date=time.to_date
      date.to_s(:long)
    end

    def pretty_time_from_to(session)
      time="#{session.start.time.to_s(:short)} - "
      if session.end.nil?
        time+=raw('<span class="label label-warning">In-progress</span>')
      else
        time+="#{session.end.time.to_s(:short)}"
      end
    end

    def pretty_hours(secs)
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

end
