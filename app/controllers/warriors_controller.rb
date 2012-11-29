class WarriorsController < ApplicationController
  # GET /warriors
  # GET /warriors.json
  helper_method :sort_column, :sort_direction

  def index
    @regions=Region.all
    @today=Warrior.todays_warriors
    @tomorrow=Warrior.tomorrows_warriors
    @day_after=Warrior.day_after_tomorrows_warriors
  end

  def list
    if params[:region]!="" && !params[:region].nil?
      @region=Region.find(params[:region])
      @warriors = Warrior.where(:region_id=>@region.id)
    else
      @region=nil
      @warriors=Warrior.scoped
    end

    @warriors = @warriors.search(params[:search]).order(sort_column+ ' ' + sort_direction).paginate(:per_page => 20, :page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.json { render json: @warriors }
    end
  end

  # GET /warriors/1
  # GET /warriors/1.json
  def show
    @warrior = Warrior.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @warrior }
    end
  end

  # GET /warriors/new
  # GET /warriors/new.json
  def new
    @warrior = Warrior.new
    @warrior.build_address
    @regions=Region.all
    @warrior_region=nil
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @warrior }
    end
  end

  # GET /warriors/1/edit
  def edit
    @warrior = Warrior.find(params[:id])
    @regions=Region.all
    @warrior_region=@warrior.region.id
  end

  # POST /warriors
  # POST /warriors.json
  def create
    @warrior = Warrior.new(params[:warrior])

    respond_to do |format|
      if @warrior.save
        format.html { redirect_to @warrior, notice: 'Warrior was successfully created.' }
        format.json { render json: @warrior, status: :created, location: @warrior }
      else
        format.html { render action: "new" }
        format.json { render json: @warrior.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /warriors/1
  # PUT /warriors/1.json
  def update
    @warrior = Warrior.find(params[:id])

    respond_to do |format|
      if @warrior.update_attributes(params[:warrior])
        format.html { redirect_to @warrior, notice: 'Warrior was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @warrior.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /warriors/1
  # DELETE /warriors/1.json
  def destroy
    @warrior = Warrior.find(params[:id])
    @warrior.destroy
    respond_to do |format|
      format.html { redirect_to warriors_url }
      format.json { head :no_content }
    end
  end

  def regional_stats
    @regions=Region.all
  end

 private
  def sort_column
    params[:sort] || "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end
end
