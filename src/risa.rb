# frozen_string_literal: true

require 'discordrb'
require 'require_all'

module Risa
  require_relative 'database'
  require_relative 'logger'
  require_all 'src/modules/*.rb'

  bot = Discordrb::Bot.new token: ENV['RISA_TOKEN'], fancy_log: true

  bot.include! Bootstrap
  bot.include! ChannelStalker
  bot.include! MemberStalker
  bot.include! MessageStalker
  bot.include! RoleStalker

  bot.run
end
