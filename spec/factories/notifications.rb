FactoryBot.define do
  factory :notification do
    new true
    notification_type :new_user
    user
    reference { create(:user).id }
  end
end
