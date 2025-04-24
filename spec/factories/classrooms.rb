FactoryBot.define do
  factory :classroom do
    name { "Test Classroom" }
    school_year { "2024-2025" }
    association :school
  end
end
