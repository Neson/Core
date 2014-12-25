FactoryGirl.define do
  factory :unit do
    university
    name { Faker::Company.name }
    short_name { name.gsub(/[^A-Z0-9]/, '') }
    sequence(:code) { |n| "#{Faker::Address.building_number}#{n}" }
  end
end
