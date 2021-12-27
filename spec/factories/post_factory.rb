# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence(word_count: 6) }
    body  { Faker::Lorem.paragraph }

    factory :published_post do
      published_at { DateTime.new }
    end
  end
end
