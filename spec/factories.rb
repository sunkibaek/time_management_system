FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Test User #{n}" }
    sequence(:email) { |n| "test_user#{n}@example.com" }
    preferred_working_hour 8
    password_digest 'testPassword'
  end

  factory :task do
    description 'Test task description'
    date '2014-12-31'
    hour 4
    user
  end
end
