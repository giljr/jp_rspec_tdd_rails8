FactoryBot.define do
  factory :member do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }  
    # confirmed_at { Date.today } # for email confirmation
  end
end
