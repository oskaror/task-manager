# frozen_string_literal: true

require 'timecop'

RSpec.configure do |config|
  config.around(:example, freezetime: true) do |spec|
    Timecop.freeze(Time.zone.now) do
      spec.run
    end
  end
end
