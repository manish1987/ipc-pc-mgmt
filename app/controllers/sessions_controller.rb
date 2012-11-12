class SessionsController < ApplicationController
  # GET /sessions
  # GET /sessions.json
    helper_method :sort_column, :sort_direction
  def index
    @todays_sessions=Session.todays_sessions.paginate(:per_page => 15, :page => params[:page])
    @todays_open=Session.todays_sessions(true).paginate(:per_page => 15, :page => params[:page])
    @all_open=Session.all_open.paginate(:per_page => 15, :page => params[:page])


    @no_sessions_today=Session.total_todays_sessions
    @sessions_month=Session.sessions_month
    @total_hours=Session.total_hours({:today=>true,:range=>nil})

    @tab=params[:tab]

    if(!@tab.nil?)
      case @tab
        when "todays_sessions"
          @sessions=@todays_sessions
        when "todays_open"
          @sessions=@todays_open
        when "all_open"
          @sessions=@all_open
      end
    end

    @regions=Region.all

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end

  end

  def statistics
    @statistics=Session.generate_stats(params[:daterange])
    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  def list
    @sessions = Session.between_dates(params[:daterange]).order(sort_column+ ' ' + sort_direction).paginate(:per_page => 20, :page => params[:page])


    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  def warrior_sessions
    @warrior=Warrior.find(params["warrior"])
    @date=params[:date]

    @sessions=Session.by_warrior_date(@warrior.id,@date).order(sort_column+ ' ' + sort_direction).paginate(:per_page => 20, :page => params[:page])


    respond_to do |format|
      format.html # warrior_sessions.html.erb
      format.json { render json: @sessions }
      format.js
    end
  end

  # GET /sessions/1
  # GET /sessions/1.json
  def show
    @session = Session.find(params[:id])
    @feedback= @session.feedback

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @session }
    end
  end

  # GET /sessions/new
  # GET /sessions/new.json
  def new
    @session = Session.new
    @warrior=Warrior.find(params[:warrior])
    @session.warrior=@warrior
    @cabins=Cabin.vacant_cabins

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @session }
    end
  end

  # GET /sessions/1/edit
  def edit
    @session = Session.find(params[:id])
  end

  # POST /sessions
  # POST /sessions.json
  def create
    @session = Session.new(params[:session])
    @session.start=Time.now
    @session.cabin.vacant=false
    @session.cabin.save

    respond_to do |format|
      if @session.save
        format.html { redirect_to @session, notice: 'Session was successfully created.' }
        format.json { render json: @session, status: :created, location: @session }
      else
        format.html { render action: "new" }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  def end_session
    @session=Session.find(params[:session])
    @session.end=Time.now
    @session.total=@session.end-@session.start
    @session.cabin.vacant=true
    @session.cabin.save
    respond_to do |format|
      if @session.save
        format.html { redirect_to @session, notice: 'Session was successfully ended.' }
        format.js
      else
        format.html { redirect_to @session, notice: 'Session Ending Failed. Try Again!'  }
        format.js { redirect_to @session, notice: 'Session Ending Failed. Try Again!'  }
      end
    end
  end


  # PUT /sessions/1
  # PUT /sessions/1.json
  def update
    @session = Session.find(params[:id])

    respond_to do |format|
      if @session.update_attributes(params[:session])
        format.html { redirect_to @session, notice: 'Session was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sessions/1
  # DELETE /sessions/1.json
  def destroy
    @session = Session.find(params[:id])
    @session.destroy

    respond_to do |format|
      format.html { redirect_to sessions_url }
      format.json { head :no_content }
    end
  end

  private
  def sort_column
    params[:sort] || "start"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"
  end
end
