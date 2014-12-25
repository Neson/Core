FactoryGirl.define do

  factory :college do
    university_code { create(:university).code }
    sequence(:name) { |n| "#{Faker::Company.name} #{n} College" }
    short_name { name.gsub(/[^A-Z0-9]/, '') }
    sequence(:code) { |n| "#{Faker::Address.building_number}#{n}" }

    factory :college_with_departments do
      transient do
        departments_count 5
      end
      after(:create) do |college, evaluator|
        create_list(:department, evaluator.departments_count, college_code: college.code, university_code: college.university_code)
      end
    end
  end
end
