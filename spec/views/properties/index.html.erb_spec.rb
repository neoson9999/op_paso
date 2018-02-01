require 'rails_helper'

RSpec.describe "properties/index", :type => :view do
  before(:each) do
    assign(:properties, [
      Property.create!(
        :name => "Name"
      ),
      Property.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of properties" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
