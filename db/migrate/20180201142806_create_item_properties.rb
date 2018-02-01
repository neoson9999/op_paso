class CreateItemProperties < ActiveRecord::Migration
  def change
    create_table :item_properties do |t|
      t.integer :item_id
      t.integer :property_id

      t.timestamps
    end
  end
end
