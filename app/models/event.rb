class Event < ActiveRecord::Base
  belongs_to :user
  has_many :points, :through => :event_points
  has_many :event_points

  validates :name, :uniqueness => true
  validates_datetime :event_date, :after => lambda { 1.hour.from_now }
end
