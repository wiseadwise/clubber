class Point < ActiveRecord::Base
  validates :address, :uniqueness => true

  belongs_to :user
  has_many :events, :through => :events_points
  has_many :event_points, :dependent => :destroy

end
