class ContactFormsController < ApplicationController

  def new
    @contact_form = Feedback.new
  end

  def create
    @contact_form = Feedback.new(params[:feedback])
    @contact_form.request = request   
    
    if @contact_form.deliver 
      redirect_to(root_path, :notice => "Thanks for your feedback")
    else
      flash.now.alert = "Please fill all fields."
      render :new
    endrescue ScriptError flash[:error] = 'Sorry, this message appears to be spam and was not delivered.'
    end
  end

end
