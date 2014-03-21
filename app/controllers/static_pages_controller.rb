class StaticPagesController < ApplicationController
  def home
    #@title = "Home"
    @events = Event.new
    @events = Event.where("workflow_state=? and edatetime > ?","accept", Time.now).reverse
   # @events = Event.where("sdatetime > ? and sdatetime < ?", Time.now.beginning_of_day + num.day, Time.now.end_of_day + num.day) if num.present?
    @tab1 = Event.where("reach_id = 1 and workflow_state=? and edatetime > ?","accept",Time.now).sort_by{|u| u.updated_at}.reverse     
    @tab2   = Event.where("reach_id = 2 and workflow_state=? and edatetime > ?","accept", Time.now ).reverse 
    @tab5   = Event.where("workflow_state=? and edatetime > ?","accept", Time.now).sort_by{|u| u.shared_by.count}.reverse
###allevents
    
    #@events = Event.all.paginate(:page => params[:page], :per_page => 7)
    @user = current_user || User.new
    @cat_array  = @user.categories #.collect{|p| p.id}
    @dom_array   = @user.domains
    @eli_array  = @user.eligibles
    
    @categor =[]
    @domai = []
    @eligibl = []
         
    @cat_array.each do |u|    
            @cat = Category.find(u.id)
            @categor = @categor << @cat.events.where("workflow_state=? and edatetime > ?","accept", Time.now).pluck(:id)       
        end
 
     @dom_array.each do |u|    
            @dom = Domain.find(u.id)
            @domai = @domai << @dom.events.where("workflow_state=? and edatetime > ?","accept", Time.now).pluck(:id) 
   
           end
        
      @eli_array.each do |u|    
            @eli = Eligible.find(u.id)
            @eligibl = @eligibl << @eli.events.where("workflow_state=? and edatetime > ?","accept", Time.now).pluck(:id) 
              end
    
         @events_array = @categor.flatten << @eligibl.flatten << @domai.flatten
         ids = @events_array.flatten
         sorted_ids = ids.sort_by{|id| ids.select{|id2| id2 == id}.size}.reverse.uniq
         records = Event.find(sorted_ids).group_by(&:id)
         @tab3 = sorted_ids.map { |id| records[id].first }
    @tab4 = @user.userfavorites.where("workflow_state=? and edatetime > ?","accept", Time.now).reverse 
    @tab6 = @user.usershares.where("workflow_state=? and edatetime > ?","accept", Time.now).reverse
    @tab7 = @user.events.reverse          
  end
  
  def new_events
  t = Time.at(params[:created_at].to_i)
     @events = Event.where("updated_at > ?",Time.at(params[:created_at].to_i))
     @user = current_user || User.new
     respond_to do |format|
        format.js
     end
  end
  
  def about
   # @title = "About"
  end
  
  def contact
   # @title = "Contact"
  end
  
  def help
   # @title = "Help"
  end
  
  def faq  
  end
  def tour
  end
  def our_works
  end
  def team
  end
  def partnerships
  end
  def show
     @events = Event.all.reverse
     respond_to do |format|
     format.js
     end
     end
      
end
