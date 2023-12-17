FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "First#{n} Last#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
  end
end
