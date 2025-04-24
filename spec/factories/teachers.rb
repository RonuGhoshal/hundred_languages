FactoryBot.define do
  factory :teacher do
    first_name { "Test" }
    last_name { "Teacher" }
    sequence(:email_address) { |n| "teacher#{n}@example.com" }
    password { "password" }
    role { "teacher" }
    association :school
  end
end 