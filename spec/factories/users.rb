# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    fullName { Faker::Name.name }
    dni { Faker::Number.number(digits: 8) }
    sequence(:email) { |n| "person#{n}@example.com" }
    password { 'password123' }
    date_of_birth { Faker::Date.birthday(min_age: 18, max_age: 65) }

    role { :basic }

    trait :subscriber do
      role { :subscriber }
    end

    trait :admin do
      role { :admin }
    end
  end
end
