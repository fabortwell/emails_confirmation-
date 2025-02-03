# app/models/user.rb
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :created_events, class_name: "Event", foreign_key: "creator_id"
  has_many :event_attendances, foreign_key: "attendee_id"
  has_many :attended_events, through: :event_attendances, source: :event
end

# app/models/event.rb
class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :event_attendances
  has_many :attendees, through: :event_attendances, source: :user

  scope :past, -> { where("date < ?", Time.current) }
  scope :upcoming, -> { where("date >= ?", Time.current) }
end
