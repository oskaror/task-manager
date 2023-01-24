# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    name { Faker::Games::Witcher.potion }
    description { Faker::Quote.yoda }
  end
end
