class EventsController < ApplicationController
before_filter :authenticate_user!, except: [:show, :index]
 #:only: [:new, :create ,:blah]
 load_and_authorize_resource :only => [:edit,:update,:destroy]
 def show
   @event = Event.find(params[:id])
   @category=@event.categories
   @domain = @event.domains
   @eligible=@event.eligibles
   @user = current_user || User.new
  end

  # GET /events
  # GET /events.json
  def index
  @user = current_user || User.new
    @events = Event.all
    @events = @events.paginate :page => params[:page], :per_page => 10
      respond_to do |format|
        format.html
        format.atom
      end
  end

  # GET /events/1
  # GET /events/1.json
# before_filter :authenticate_user!
  # GET /events/new
  def new
    @event = Event.new

  
  end

  # GET /events/1/edit
  def edit
  @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
     @event.user_id = current_user.id
     # @event.save!
  if signed_in?
    respond_to do |format|
      if @event.save
            
     # debugger
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
end
   else 
       redirect_to signin_path
       flash[:notice] = 'Please signin first'
   end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
 def update

  @event = Event.find(params[:id]) 
    respond_to do |format|
      if @event.update_attributes(event_params)
       
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def submit
    @event = Event.find(params[:id])
    @event.update_column(:workflow_state,"submit")
    redirect_to @event, notice: "Submitted for approval"
  end
  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    if @event.present?
    @event.destroy
    end
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
    
 def favorite
 @event = Event.find(params[:id])
    type = params[:type]
    if type == "favorite"
      current_user.userfavorites << @event
      redirect_to :back, notice: "You favorited #{@event.title}"

    elsif type == "unfavorite"
      current_user.userfavorites.delete(@event)
      redirect_to :back, notice: "Unfavorited #{@event.title}"

    else
      # Type missing, nothing happens
      redirect_to :back, notice: 'Nothing happened.'
    end
  end
  
  def share
 @event = Event.find(params[:id])
    type = params[:type]
    if type == "share"
      current_user.usershares << @event
      redirect_to :back, notice: "You promoted the event #{@event.title}"

    elsif type == "undo share"
      current_user.usershares.delete(@event)
      redirect_to :back, notice: "Undo promote #{@event.title}"

    else
      # Type missing, nothing happens
      redirect_to :back, notice: 'Nothing happened.'
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:email,:contact_name,:title,:sdatetime,:venue,
      :location,:events_description,:short_description,:email,:user_id,:organizer,
      :edatetime,:contact_phone,{:domain_ids =>[]},{:category_ids =>[]},{:eligible_ids =>[]},:avatar,:web,:reach_id,:workflow_state)                              
    end
end
