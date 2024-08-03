FactoryBot.define do
  factory :user do
    name { "hiro" }
    sequence(:email) { |n| "hiro#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
