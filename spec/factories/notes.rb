FactoryBot.define do
  factory :note do
    content { "This is a test note" }
    association :author, factory: :teacher
  end
end 