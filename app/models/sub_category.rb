class SubCategory < ActiveRecord::Base
  attr_accessible :name

  belongs_to :category
  belongs_to :parent, class_name: 'SubCategory', foreign_key: 'parent_id'
  has_many :children, class_name: 'SubCategory', foreign_key: 'parent_id'

  has_many :items

  before_save :assign_depth
  before_destroy :remove_association

  scope :root, -> { where(parent_id: nil) }

  DEFAULT_DEPTH = 0

  def parent_name
    @p_name ||=
      if parent.present?
        parent.name
      else
        ''
      end
  end

  def assign_depth
    if parent.present? && parent.depth.present?
      self.depth = parent.depth + 1
    else
      self.depth = DEFAULT_DEPTH
    end
  end

  def assign_depth_and_save
    assign_depth
    save!
  end

  private

  def remove_association
    children = self.children
    children_ids = children.pluck(:id)
    children.update_all(parent_id: nil)
    recompute_depth_of_descendants(children_ids)
  end

  def recompute_depth_of_descendants(sub_category_ids)
    child_sub_categories = SubCategory.where(id: sub_category_ids)
    return if child_sub_categories.blank?
    child_sub_categories.each(&:assign_depth_and_save)
    child_sub_category_ids = child_sub_categories.flat_map(&:children).map(&:id)
    recompute_depth_of_descendants(child_sub_category_ids)
  end
end
