require 'qr_image'
class Point < ActiveRecord::Base
  before_create :set_visit_number
  after_destroy :delete_code

  belongs_to :user

  def set_visit_number
    self.visit_number = 0
  end

  def delete_code
    File.delete(self.qr_path) if File.exist?(self.qr_path)
  end

  QR_IMAGES_DIR = File.join(Rails.root, 'public/qr')
  QR_SIZE = 5

  def create_qr_image(request)
    QrImage.create_image(qr_path, qr_text(request), QR_SIZE, 10, 10)
  end

  def qr_text(request)
    "#{request.protocol}#{request.host}/p/v/#{self.id}"
  end

  def qr_code(request)
    QrImage.get_code(qr_text(request), QR_SIZE)
  end

  def qr_url
    File.join('qr/', "#{self.id}.jpg")
  end

  def qr_path
    File.join(QR_IMAGES_DIR, "#{self.id}.jpg")
  end

  def visit!
    self.visit_number += 1
    self.save
  end

end
