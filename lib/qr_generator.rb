require 'fileutils'
module QrGenerator

  def delete_code
    path = absolute_qr_path(qr_path)
    File.delete(path) if File.exist?(path)
  end

  def create_qr_image
    path = absolute_qr_path(qr_path)
    dir = File.dirname(path)
    FileUtils.mkdir_p(dir) unless File.exist?(dir)
    system "qrencode -s 10 -m 3 -o #{path} '#{qr_text}'"
  end

  private

  def absolute_qr_path(path)
    File.join(Rails.public_path, path)
  end

end
