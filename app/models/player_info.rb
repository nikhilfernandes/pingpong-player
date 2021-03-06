class PlayerInfo
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  attr_accessor :name, :identity, :password, :host, :port, :path, :defence_set_length

  def initialize(attributes={})        
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def payload
    {player: {identity: self.identity, name: self.name, defence_length: self.defence_set_length, host: self.host , port: self.port , path: self.path}}        
  end
  
end

