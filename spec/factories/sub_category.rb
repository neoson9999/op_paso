FactoryGirl.define do
  factory :sub_category, class: SubCategory do
    category
    sequence(:name) { |n| "SubCategory#{n}-#{depth}" }
    depth 0
    parent_id nil
  end
end
