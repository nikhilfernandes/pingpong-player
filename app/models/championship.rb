class Championship < ActiveRecord::Base
  has_one :player
  has_many :games
end