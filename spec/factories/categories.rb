FactoryBot.define do
  factory :category do
    name { Faker::Name.name }
    active true
  end
end
