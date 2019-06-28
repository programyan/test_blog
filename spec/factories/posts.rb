# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title { Faker::Lorem.word }
    body { Faker::Lorem.sentence }
    ip { Faker::Internet.public_ip_v4_address }
    login { Faker::Internet.username }

    user { create(:user, login: login) }

    trait :without_user do
      user { nil }
    end
  end
end
