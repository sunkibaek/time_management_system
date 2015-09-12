FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Test User #{n}" }
    sequence(:email) { |n| "test_user#{n}@example.com" }
    password_digest 'testPassword'
  end

  factory :task do
    description 'Test task description'
    date '31/12/2014'
    hour 4
    user
  end
end
