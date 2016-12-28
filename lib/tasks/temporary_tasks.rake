namespace :one_time do
  desc 'assigns depth to existing sub categories without depth'
  task assign_depth_to_sub_categories: :environment do
    root_sub_categories = SubCategory.root
    root_sub_categories.each(&:assign_depth_and_save)
    assign_depth_where_parent_in(root_sub_categories.pluck(:id))
  end

  def assign_depth_where_parent_in(sub_category_ids)
    child_sub_categories = SubCategory.where(parent_id: sub_category_ids)
    return if child_sub_categories.blank?
    child_sub_categories.each(&:assign_depth_and_save)
    assign_depth_where_parent_in(child_sub_categories.pluck(:id))
  end
end
