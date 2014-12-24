FactoryGirl.define do
  factory :email_pattern do
    university
    sequence(:priority) { |n| n }
    identity Constant::USER_IDENTITY.values.sample
    regexp "^(?<sid>[A-Za-z0-9]+)@example\.com$"

    trait :ntust_student do
      university nil
      university_code 'NTUST'
      priority 1
      identity Constant::USER_IDENTITY[:student]
      regexp '^(?<sid>(?<identity_detail>[aAbmdBMD])(?<started_at>\\d*)(?<department_code>\\d{2})\\d{3})@mail\\.ntust\\.edu\\.tw$'
      sid_eval "n.toLowerCase()"
      identity_detail_eval "switch (n.toLowerCase()) { case 'a': 'a'; break; case 'b': 'bachelor'; break; case 'm': 'master'; break; case 'd': 'doctor'; break; }"
      started_at_eval "new Date((parseInt(n)+1911) + '-9')"
    end

    trait :ntust_staff do
      university nil
      university_code 'NTUST'
      priority 2
      identity Constant::USER_IDENTITY[:staff]
      regexp '^(?<sid>.+)@mail\\.ntust\\.edu\\.tw$'
      sid_eval "n.toLowerCase()"
    end
  end
end
