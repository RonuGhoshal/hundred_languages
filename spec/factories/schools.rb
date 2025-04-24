FactoryBot.define do
  factory :school do
    name { "Test School" }
    address { "123 Test St" }
    city { "Test City" }
    state { "Test State" }
    zip { "12345" }
    phone { "1234567890" }
  end
end