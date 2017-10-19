class User < ActiveRecord::Base
  has_secure_password
  has_many :events
  has_many :event_attendings, through: :event_attendees, source: :event, dependent: :destroy

  has_many :comments
  # I have an error here when I write this, why??


  validates :firstname, :lastname, length: {minimum: 2}
  validates :email, presence: true
  
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates_uniqueness_of :email
  
  def email= email
    super(email.try(:downcase))
  end

  validates :location, presence: true, length: {minimum: 2}
  validates :password, presence: true, length: {in: 8..30}, on: :create
end
