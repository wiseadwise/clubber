class SimpleText < QrItem
  PROPERTIES = [:text]
  belongs_to :user

  def item_name
    name
  end

  def qr_data
    properties[:text]
  end
end
