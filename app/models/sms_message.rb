class SmsMessage < QrItem
  PROPERTIES = [:phone, :message]
  belongs_to :user

  def item_name
    name.blank? ? properties[:phone] : name
  end

  def qr_text
    "SMSTO:#{phone}:#{message}"
  end

end
