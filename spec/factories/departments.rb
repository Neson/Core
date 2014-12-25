FactoryGirl.define do
  factory :department do
    university_code { create(:university).code }
    college_code { create(:college, university: university).code }
    sequence(:name) { |n| "#{Faker::Company.name} #{n} Department" }
    short_name { name.gsub(/[^A-Z0-9]/, '') }
    sequence(:code) { |n| "#{Faker::Address.building_number}#{n}" }
  end
end
