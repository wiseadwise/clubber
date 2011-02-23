require 'qr_image'
class EventPoint < ActiveRecord::Base
  QR_IMAGES_DIR = File.join(Rails.root, 'public/qr')
  QR_SIZE = 5

  belongs_to :event
  belongs_to :point

  after_destroy :delete_code

  def delete_code
    File.delete(self.qr_path) if File.exist?(self.qr_path)
  end

  def create_qr_image(attributes)
    QrImage.create_image(qr_path, qr_text(attributes), QR_SIZE, 10, 10)
  end

  def qr_text(attributes)
    "#{attributes[:protocol]}#{attributes[:host]}/p/v/#{self.id}"
  end

  def qr_code(attributes)
    QrImage.get_code(qr_text(attributes), QR_SIZE)
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
