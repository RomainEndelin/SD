FactoryBot.define do
  factory :discussion do
    content { Faker::Lorem.paragraph }
    article
    author

    factory :invalid_discussion do
      content nil
    end
  end
end
