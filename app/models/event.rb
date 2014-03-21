class Event < ActiveRecord::Base
#attr_accessor :upload, :edate, :contact_phone 
attr_accessible :title,:organizer,:location,
                            :sdatetime,:edatetime,:contact_name ,
                           :contact_phone, :email,:short_description,
                            :events_description,:venue, :user_id, :avatar,:category_ids,
                 :domain_ids, :eligible_ids,:favorites, :shares, :web,
                 :reach_id,:workflow_state
                                 
validates :title, :presence => true, length: {maximum: 50}
validates_datetime :sdatetime, :after => Time.now + 45.minutes 
validates_datetime :edatetime, :after => :sdatetime
validates :organizer, :presence => true
validates :venue, :presence => true
validates :reach_id, :presence => true
validates :location, :presence => true
validates :events_description, :presence => true
VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
validates :short_description, :presence => true, :length => { :maximum => 140}
VALID_PHONE = /([0]|\+91)?[789]\d{9}/
validates :contact_phone, :presence => true, format: { with: VALID_PHONE }
 has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_attachment :avatar, :size => { :in => 0..150.kilobytes },
 :content_type => { :content_type => ["image/jpg", "image/gif", "image/png"] }
validates :user_id, :presence => true
has_many :pushids, :dependent => :destroy
has_many :favorites, :dependent => :destroy
has_many :shares, :dependent => :destroy
has_many :followfeeds, :dependent => :destroy
has_and_belongs_to_many :categories
has_and_belongs_to_many :domains
has_and_belongs_to_many :eligibles
belongs_to :user
has_many :favorited_by, through: :favorites, source: :user
has_many :shared_by, through: :shares, source: :user
has_many :followfeeds_by, through: :followfeeds, source: :user
belongs_to :reach
include Workflow
  workflow do
    state :new do
      event :submit, :transitions_to => :being_reviewed
    end
    state :being_reviewed do
      event :accept, :transitions_to => :accepted
      event :reject, :transitions_to => :rejected
    end
    state :accepted
    state :rejected
  end
end
