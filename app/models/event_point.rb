require 'qr_image'

class EventPoint < ActiveRecord::Base
  include QrGenerator
  QR_SIZE = 5

  belongs_to :event
  belongs_to :point

  validates :point_id, :uniqueness => { :scope => [:event_id] }

  after_destroy :delete_code
  after_create  :create_qr_image

  def qr_text
    "#{Clubber::Application.config.protocol}://#{Clubber::Application.config.domain}/p/v/#{self.id}"
  end

  def qr_code
    QrImage.get_code(qr_text, QR_SIZE)
  end

  def qr_path
    "/qr/event_points/#{id}.jpg"
  end

  def visit!
    self.visit_number += 1
    self.save
  end

end
