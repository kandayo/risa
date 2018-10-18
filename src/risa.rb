# frozen_string_literal: true

require 'discordrb'
require 'require_all'

module Risa
  require_relative 'database'
  require_relative 'logger'

  bot = Discordrb::Bot.new token: ENV['RISA_TOKEN'], fancy_log: true

  require_all 'src/modules/*.rb'
  constants.each { |mod| bot.include! const_get(mod) }

  bot.run
end
