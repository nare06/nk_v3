namespace :notifier do
	task :event_notifications => :environment do
		events = Event.where(:created_at => (Time.now-7.day)..Time.now).all
     User.all.each do |u|

	UserMailer.events_notify(u, events).deliver if events.count > 0

		end
	end
end
