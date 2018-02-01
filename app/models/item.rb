class Item < ActiveRecord::Base
  attr_accessible :name, :sub_category_id
  belongs_to :sub_category

  has_many :item_properties
  has_many :properties, through: :item_properties
end
