class RefreshController < ApplicationController
before_filter :authenticate_user!, only: :myevents
def index
@cat = Category.find(params[:category][:category_id]) if params[:category][:category_id].present?
  @dom = Domain.find(params[:domain][:domain_id]) if params[:domain][:domain_id].present?
  @eli = Eligible.find(params[:eligible][:eligible_id]) if params[:eligible][:eligible_id].present?
  ids = [@cat, @dom, @eli].reject(&:blank?).collect(&:event_ids).flatten
  sorted_ids = ids.sort_by{|id| ids.select{|id2| id2 == id}.size}.reverse.uniq
  records = Event.find(sorted_ids).group_by(&:id)
  @all = sorted_ids.map { |id| records[id].first }
  @user = current_user || User.new  

#@event_ids || @events.collect{|p| p.id}
#@event_ids = id_array.collect{|id| id.to_i}

end
def by_date
date = params[:date]
num = params[:num]
week = params[:week]
@user = current_user || User.new
if date.present?
time = Date.new(date["year"].to_i,date["month"].to_i,date["day"].to_i)

    @all = Event.where("sdatetime > ? and sdatetime < ?", time.beginning_of_day, time.end_of_day).reverse 
    render "index"
    elsif num.present?    
     @all = Event.where("sdatetime > ? and sdatetime < ?", Time.now.beginning_of_day, Time.now.end_of_day+ num.to_i.days).reverse
     render "index"
     elsif week.present?
       @all = Event.where("sdatetime > ? and sdatetime < ?", Time.now.beginning_of_week, Time.now.end_of_week).reverse
       render "index"
     else
     @all = Event.where("sdatetime > ? and sdatetime < ?", Time.now.beginning_of_month, Time.now.end_of_month).reverse
     render "index"
     end
end

def myevents
@user = current_user || User.new
    @cat_array  = @user.categories #.collect{|p| p.id}
    @dom_array   = @user.domains
    @eli_array  = @user.eligibles
    
    @categor =[]
    @domai = []
    @eligibl = []
         
    @cat_array.each do |u|    
            @ca = Category.find(u.id)
            @categor = @categor << @ca.events.collect{|p| p.id}       
        end
 
     @dom_array.each do |u|    
            @do = Domain.find(u.id)
            @domai = @domai << @do.events.collect{|p| p.id}
   
           end
        
      @eli_array.each do |u|    
            @el = Eligible.find(u.id)
            @eligibl = @eligibl << @el.events.collect{|p| p.id}
              end
         @events_array = @categor.flatten << @eligibl.flatten << @domai.flatten
         ids = @events_array.flatten
         sorted_ids = ids.sort_by{|id| ids.select{|id2| id2 == id}.size}.reverse.uniq
         records = Event.find(sorted_ids).group_by(&:id)
         @all = sorted_ids.map { |id| records[id].first }
    render "index"
end
def hallevents
@user = current_user || User.new
 @all = Event.where("reach_id = 2").sort_by{|u| u.updated_at}.reverse     
    render "index"
end
def campusevents
@user = current_user || User.new
@all   = Event.where("reach_id = 1").reverse 
render "index"
end

end

