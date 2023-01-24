# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    name { Faker::Games::Witcher.potion }
    description { Faker::Quote.yoda }

    project

    trait :with_user do
      user
    end
  end
end
