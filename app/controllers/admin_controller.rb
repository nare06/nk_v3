class AdminController < ApplicationController

before_filter :authenticate_user!
#load_and_authorize_resource
#before_filter :authenticate_admin!
authorize_resource :class => false
def index
@user = current_user
@all = Event.where.not("workflow_state=? or workflow_state=?","accept","reject").reverse
render "index"
end

def update
@user = current_user
@event = Event.find(params[:id])


       respond_to do |format|
  if @event.update_column(:workflow_state,params[:state])
        format.html { redirect_to approvals_path, notice: "Event #{params[:state]}ed." }
        format.json { head :no_content }
      else
        format.html { redirect_to approvals_path, notice:'Not successful' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
       
   end
    
end
end
