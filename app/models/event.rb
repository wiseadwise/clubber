class Event < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :points
  validates :name, :uniqueness => true
  validates_datetime :event_date, :after => lambda { 1.hour.from_now }
end
