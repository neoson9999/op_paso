class AddDepthToSubCategory < ActiveRecord::Migration
  def change
    add_column :sub_categories, :depth, :integer
  end
end
