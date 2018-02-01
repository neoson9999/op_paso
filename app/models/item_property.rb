class ItemProperty < ActiveRecord::Base
  attr_accessible :item_id, :property_id

  belongs_to :item
  belongs_to :property
end
