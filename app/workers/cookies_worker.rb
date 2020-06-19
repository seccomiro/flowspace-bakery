# frozen_string_literal: true

class CookiesWorker
  include Sidekiq::Worker

  def perform(oven_id, oven_time)
    puts "Start Cooking: #{oven_time} seconds" unless Rails.env.test?

    sleep oven_time

    oven = Oven.find_by!(id: oven_id)
    oven.cookies.each do |cookie|
      cookie.update_attributes!(ready: true)
    end

    puts 'Finish Cooking' unless Rails.env.test?
  end
end
