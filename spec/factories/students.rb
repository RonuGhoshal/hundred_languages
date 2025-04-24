FactoryBot.define do
  factory :student do
    first_name { "Test" }
    last_name { "Student" }
    dob { Date.today - 10.years }
    photo_url { "https://example.com/photo.jpg" }
    association :school
    association :active_classroom, factory: :classroom
  end
end 