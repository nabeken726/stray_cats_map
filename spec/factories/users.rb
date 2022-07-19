FactoryBot.define do
  factory :user do
    password { "password" }
    email { "test@test.com" }
    name {"test"}
  end
end
