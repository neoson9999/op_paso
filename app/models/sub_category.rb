class SubCategory < ActiveRecord::Base
  attr_accessible :name
  belongs_to :category
  belongs_to :parent, class_name: 'SubCategory', foreign_key: 'parent_id'
  has_many :children, class_name: 'SubCategory', foreign_key: 'parent_id'

  def parent_name
    @p_name ||=
      if parent.present?
        parent.name
      else
        ''
      end
  end
end
