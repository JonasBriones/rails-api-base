# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    fullName { Faker::Name.name }
    dni { Faker::Number.number(digits: 8) }
    sequence(:email) { |n| "person#{n}@example.com" }
    password { 'password123' }
  end
end
