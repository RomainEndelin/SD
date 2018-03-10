FactoryBot.define do
  factory :user, aliases: [:author] do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    created_at 10.minutes.ago
    confirmed_at 10.minutes.ago

    city { Faker::Address.city }
    country 'FR'

    admin false

    factory :admin do
      admin true
    end

    after :create do |u|
      u.update_column(:avatar, File.join(Rails.root, 'spec', 'support', 'images', 'avatar.jpg'))
      u.update_column(:background_picture, File.join(Rails.root, 'spec', 'support', 'images', 'background_image.jpg'))
    end
  end
end
