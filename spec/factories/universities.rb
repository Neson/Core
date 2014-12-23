FactoryGirl.define do
  factory :university do
    sequence(:name) { |n| "#{Faker::Company.name} #{n} University" }
    code { "#{name.gsub(/[^A-Z0-9]/, '')}" }
    short_name { "#{name.gsub(/[^A-Za-z0-9]/, '').gsub(/University$/, 'Uni')}" }

    trait :ntust do
      code 'NTUST'
      name '國立臺灣科技大學'
      short_name '台科大'
      after(:create) do |ntust|
        ntust.email_regexps << create(:email_regexp, :ntust_student)
        ntust.email_regexps << create(:email_regexp, :ntust_staff)
      end
    end
  end
end
