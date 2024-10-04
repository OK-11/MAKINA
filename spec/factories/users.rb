FactoryBot.define do
  factory :user do
    name { "test" }
    email { "test@test.com" }
    password { "password" }
    password_confirmation { "password" }
  end

  factory :admin, class: User do
    name { "admin" }
    email { "test@test.com" }
    password { "password" }
    password_confirmation { "password" }
    admin { true }
    position { 2 }
  end

  factory :worker, class: User do
    name { "worker" }
    email { "test@test.com" }
    password { "password" }
    password_confirmation { "password" }
    position { 2 }
  end

end
