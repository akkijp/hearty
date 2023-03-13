require 'securerandom'

FactoryBot.define do
  factory :account do
    sequence(:email) { |n| "tester-#{SecureRandom.hex(10)}-#{n}@example.com" }
    password { "dottle-nouveau" }
    password_confirmation { "dottle-nouveau" }
    status { "active" }
  end
end
