class AreasController < ApplicationController
  # GET /areas
  # GET /areas.json
  def index
    @areas = Area.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @areas }
    end
  end

  # GET /areas/1
  # GET /areas/1.json
  def show
    @area = Area.find(params[:id])
		@slots = Slot.find(:all, :conditions => {:area_id => @area.id})

		@village = Village.find(:first, :conditions => {:id => @area.village_id } )
		@event = Event.find(:first, :conditions => {:id => @village.event_id } )
		@num_days = (@event.end_date - @event.start_date).to_i
	
		@slots_array = Array.new

		(0 .. @num_days).each do |i|
			j = ActiveSupport::JSON
			temp = Slot.find(:all, :conditions => {:area_id => @area.id, :start_date => @event.start_date + i})

			@slots_array << (j.encode(temp))
			puts @slots_array
		end		

		respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @area }
    end
  end

  # GET /areas/new
  # GET /areas/new.json
  def new
    @area = Area.new
		@area.update_attributes(:village_id => params[:village_id])

    respond_to do |format|
      format.html {render :layout => false}# new.html.erb
      format.json { render json: @area }
    end
  end

  # GET /areas/1/edit
  def edit
    @area = Area.find(params[:id])
		render :layout => false
  end

  # POST /areas
  # POST /areas.json
  def create
    @area = Area.new(params[:area])

    respond_to do |format|
      if @area.save
        format.html { redirect_to @area, notice: 'Area was successfully created.' } 
				format.json { render json: @area, status: :created, location: @area } 
			else
        format.html { render action: "new" }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /areas/1
  # PUT /areas/1.json
  def update
    @area = Area.find(params[:id])

    respond_to do |format|
      if @area.update_attributes(params[:area])
        format.html { redirect_to @area, notice: 'Area was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /areas/1
  # DELETE /areas/1.json
  def destroy
    @area = Area.find(params[:id])
    @area.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end
end
