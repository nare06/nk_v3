class UserMailer < ActionMailer::Base
  def events_notify(user, events)
           @user = user
           @events = events
            mail(:from => "kampusbee@gmail.com",
                     :to => user.email,
                     :subject => "Kampusbee: Event Logs")
                     
            end
end
