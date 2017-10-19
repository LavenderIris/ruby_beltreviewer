class Event < ActiveRecord::Base
  belongs_to :user
  has_many :event_attendees
  has_many :comments, dependent: :destroy
  has_many :users, through: :event_attendees, source: :user , dependent: :destroy
  validates :name, :location, presence: true
  # validates :date, inclusion: {in: Date.today..Date.today+20.years, message: "date has to be in the future" }
  validates_each :date do |record, attr, value|
    record.errors.add(attr, "date must be in the future")  if value < Date.today
  end
end
