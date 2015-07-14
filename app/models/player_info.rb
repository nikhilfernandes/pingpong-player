class PlayerInfo
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  attr_accessor :name, :email, :password, :host, :port, :path, :defence_set_length

  def initialize(attributes={})        
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
end

