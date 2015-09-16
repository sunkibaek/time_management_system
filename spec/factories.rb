FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Test User #{n}" }
    sequence(:email) { |n| "test_user#{n}@example.com" }
    preferred_working_hour 8
    password_digest 'testPassword'
    roles ['regular']
  end

  factory :user_manager, class: User do
    name 'User Manager'
    email 'user_manager@example.com'
    preferred_working_hour 8
    password_digest 'testPassword'
    roles ['regular', 'user_manager']
  end

  factory :task do
    description 'Test task description'
    date '12/31/2014'
    hour 4
    user
  end
end
