class Role < ActiveRecord::Base
  attr_accessible :name, :user_ids
  has_many :assignments
  has_many :users, :through => :assignments
  
end
