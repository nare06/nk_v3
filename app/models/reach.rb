class Reach < ActiveRecord::Base
attr_accessible :name
has_many :events
 rails_admin do 
  edit do
      field :name 
      end 
    end
    validates :name, :uniqueness => {:case_sensitive => false}
end
