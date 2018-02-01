require 'rails_helper'

RSpec.describe "properties/show", :type => :view do
  before(:each) do
    @property = assign(:property, Property.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
