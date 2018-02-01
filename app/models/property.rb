class Property < ActiveRecord::Base
  attr_accessible :name

  has_many :item_properties
end
