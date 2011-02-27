require 'qr_image'
class EventPoint < ActiveRecord::Base
  QR_IMAGES_DIR = File.join(Rails.root, 'public/qr')
  QR_SIZE = 5

  belongs_to :event
  belongs_to :point

  validates :point_id, :uniqueness => { :scope => [:event_id] }

  after_destroy :delete_code
  after_create  :create_qr_image

  def delete_code
    File.delete(self.qr_path) if File.exist?(self.qr_path)
  end

  def create_qr_image
    #QrImage.create_image(qr_path, qr_text, QR_SIZE, 10, 10)
    system "qrencode -s 10 -m 3 -o #{qr_path} '#{qr_text}'"
  end

  def qr_text
    "#{Clubber::Application.config.protocol}://#{Clubber::Application.config.domain}/p/v/#{self.id}"
  end

  def qr_code
    QrImage.get_code(qr_text, QR_SIZE)
  end

  def qr_url
    File.join('/qr/', "#{self.id}.jpg")
  end

  def qr_path
    File.join(QR_IMAGES_DIR, "#{self.id}.jpg")
  end

  def visit!
    self.visit_number += 1
    self.save
  end

end
