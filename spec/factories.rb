FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Test User #{n}" }
    sequence(:email) { |n| "test_user#{n}@example.com" }
    password_digest 'testPassword'
  end
end
