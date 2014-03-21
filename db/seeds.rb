# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
records = JSON.parse(File.read('/home/naveen/rails_projects/nk_v1/app/user_2014-03-09_19h19m08.json'))
records.each do |record|
  User.create!(record)
end
