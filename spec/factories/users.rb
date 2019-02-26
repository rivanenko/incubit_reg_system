FactoryBot.define do
  sequence(:email) { |n| "#{n}#{Faker::Internet.email}" }

  factory :user do
    email                 { generate(:email) }
    password              { Faker::Internet.password(8) }
    password_confirmation { password }
  end
end