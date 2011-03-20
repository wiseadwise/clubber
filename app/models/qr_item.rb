class QrItem < ActiveRecord::Base
  serialize :properties
  belongs_to :user

  def prepare
    self.class::PROPERTIES.each do |key|
      instance_eval(<<-METHODS)
        def #{key}
          properties[:#{key}]
        end
        def #{key}=(value)
          properties[:#{key}] = value
        end
      METHODS
    end
  end

  def save_properties!(attributes)
    update_attributes(attributes)
    properties = attributes.slice(self.class::PROPERTIES.map {|p| p.to_s})
    save!
  end

  def properties
    super ? super : self.properties = {} 
  end

end
