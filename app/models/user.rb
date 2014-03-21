class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :confirmable 

attr_accessible :name, :email, :password, :password_confirmation, :category_ids,
                 :domain_ids, :eligible_ids,:event_ids, :favorites, :shares,:avatar,
                 :roles,:aboutme,:role
        validates_presence_of :email
has_many :microposts, :dependent => :destroy
has_many :relationships, :foreign_key => "follower_id",
                         :dependent => :destroy
has_many :followed_users, :through => :relationships, :source => :followed
has_many :reverse_relationships, :foreign_key => "followed_id",
                          :class_name  =>"Relationship",               
                          :dependent => :destroy
has_many :followers, :through => :reverse_relationships, :source => :follower
has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_attachment :avatar,:size => { :in => 0..150.kilobytes },
  :content_type => { :content_type => ["image/jpg", "image/gif", "image/png"] }

has_many :authorizations, :dependent => :destroy
has_many :events
has_and_belongs_to_many :roles
#User can have many preferences or zero preferences
has_and_belongs_to_many :categories
has_and_belongs_to_many :domains
has_and_belongs_to_many :eligibles 
has_many :pushids, :dependent => :destroy
has_many :favorites, :dependent => :destroy
has_many :shares, :dependent => :destroy
has_many :followfeeds, :dependent => :destroy
has_many :userfavorites, through: :favorites, source: :event
has_many :usershares, through: :shares, source: :event
has_many :userfollowfeeds, through: :followfeeds, source: :event
#ends here

has_many :assignments
  has_many :roles, :through => :assignments
=begin
 rails_admin do 
  list do
  configure :email do
    visible do 
      bindings[:view]._current_user.has_role? :superadmin
  end
  end
end
end
=end
def has_role?(role_sym)
  roles.any? { |r| r.name.underscore.to_sym == role_sym }
end

 def self.new_with_session(params,session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"],without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def self.from_omniauth(auth, current_user)
    authorization = Authorization.where(:provider => auth.provider, :uid => auth.uid.to_s).first_or_initialize
    if authorization.user.blank?
      user = current_user.nil? ? User.where('email = ?', auth["info"]["email"]).first : current_user
      if user.blank?
       user = User.new
       user.password = Devise.friendly_token[0,10]
       user.name = auth.info.name
       user.email = auth.info.email
       user.skip_confirmation!
       auth.provider == "twitter" ?  user.save(:validate => false) :  user.save
      
     end      
      authorization.user_id = user.id
      authorization.username = auth.info.nickname
     end
     authorization.secret = auth.credentials.refresh_token if auth.credentials.refresh_token.present?
     authorization.token = auth.credentials.token  
     authorization.save! 
     authorization.user
 end
      def skip_confirmation!
        super
      end
def following?(other_user)
   relationships.find_by_followed_id(other_user.id)
end
def followed_users?(other_user)
  relationships.find_by_followed_id(other_user.id)
end
def follow!(other_user)
  relationships.create!(followed_id: other_user.id)
end
def unfollow!(other_user)
  relationships.find_by_followed_id(other_user.id).destroy
end

private
def current_user
super
end
end
