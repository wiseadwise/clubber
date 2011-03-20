class Vcard < QrItem
  PROPERTIES = [:first_name, :last_name, :phone, :email]
  serialize :properties
  belongs_to :user

  def item_name
    name.blank? ? "#{properties[:first_name]} #{properties[:last_name]}" : name
  end

  def qr_data
    <<-DATA
      BEGIN:VCARD
        FN:#{first_name} #{last_name}
        TEL:#{phone}
        EMAIL:#{email}
      END:VCARD
    DATA
  end
end
