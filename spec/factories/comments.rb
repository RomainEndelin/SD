# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :comment do
    author
    content { Faker::Lorem.paragraph }
    article

    factory :invalid_comment do
      content nil
    end
  end
end
