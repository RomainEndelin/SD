FactoryBot.define do
  factory :article do
    title   { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
    description { Faker::Lorem.paragraph(1) }
    author
    city { Faker::Address.city }
    country 'FR'
    status :published

    ignore_picture true

    factory :invalid_article do
      title nil
    end

    after :create do |a|
      a.update_column(:picture, File.join(Rails.root, 'spec', 'support', 'images', 'background_image.jpg'))
    end
  end
end
