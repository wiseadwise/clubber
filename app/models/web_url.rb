class WebUrl < QrItem
  PROPERTIES = [:url]
  belongs_to :user
  def item_name
    name.blank? ? properties[:url] : name
  end

  def get_url
    (properties[:url].include?('://') ? '' : 'http://') + properties[:url]
  end
end
