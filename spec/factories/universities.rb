FactoryGirl.define do
  factory :university do
    sequence(:code) { |n| "UNI#{n}" }
    sequence(:name) { |n| "My University ##{n}" }
    sequence(:short_name) { |n| "MUNI##{n}" }
  end
end
