FactoryGirl.define do
  factory :university do
    sequence(:name) { |n| "#{Faker::Company.name} #{n} University" }
    code { "#{name.gsub(/[^A-Z0-9]/, '')}" }
    short_name { "#{name.gsub(/[^A-Za-z0-9]/, '').gsub(/University$/, 'Uni')}" }
  end
end
