FactoryBot.define do
  factory :comment do
    content { "This is a test comment" }
    association :author, factory: :teacher
    association :note
  end
end
