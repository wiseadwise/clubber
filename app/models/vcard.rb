class Vcard < QrItem
  PROPERTIES = [:first_name, :last_name, :phone, :email]
  serialize :properties
  belongs_to :user

  def item_name
    name.blank? ? "#{properties[:first_name]} #{properties[:last_name]}" : name
  end

  def qr_data
    self.prepare
    "BEGIN:VCARD\nVERSION:2.1\nN:#{first_name};#{last_name}\nTEL;HOME;VOICE:#{phone}\nEMAIL:#{email}\nEND:VCARD"
  end
end
