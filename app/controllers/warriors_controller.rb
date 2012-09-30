class WarriorsController < ApplicationController
  # GET /warriors
  # GET /warriors.json

  def index
    regions=Regions.all
  end

  def list
    @warriors = Warrior.all

    respond_to do |format|
      format.html # index.html.erb
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

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @warrior }
    end
  end

  # GET /warriors/1/edit
  def edit
    @warrior = Warrior.find(params[:id])
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
end
