FactoryGirl.define do
  factory :email_regexp do
    university
    sequence(:priority) { |n| n }
    identity Constant::USER_IDENTITY.values.sample
    regexp "^(?<sid>[A-Za-z0-9]+)@example\.com$"
  end
end
