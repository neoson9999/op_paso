require 'rails_helper'

RSpec.describe "items/new", :type => :view do
  before(:each) do
    assign(:item, Item.new(
      :name => "MyString",
      :sub_category_id => 1
    ))
  end

  it "renders new item form" do
    render

    assert_select "form[action=?][method=?]", items_path, "post" do

      assert_select "input#item_name[name=?]", "item[name]"

      assert_select "input#item_sub_category_id[name=?]", "item[sub_category_id]"
    end
  end
end
