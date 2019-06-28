# frozen_string_literal: true

FactoryBot.define do
  factory :rank do
    post
    rank { (1..5).to_a.sample }
  end
end
