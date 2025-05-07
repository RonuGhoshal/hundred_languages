FactoryBot.define do
  factory :note do
    content { "This is a test note" }
    association :author, factory: :teacher
    students { [ association(:student) ] }
  end
end
