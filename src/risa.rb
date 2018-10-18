# frozen_string_literal: true

require 'discordrb'
require 'require_all'

module Risa
  require_relative 'database'
  require_relative 'logger'
  require_all 'src/modules/*.rb'

  BOT = Discordrb::Bot.new token: ENV['RISA_TOKEN'], fancy_log: true

  BOT.include! Bootstrap
  BOT.include! Registration
  BOT.include! ChannelStalker
  BOT.include! MemberStalker
  BOT.include! MessageStalker
  BOT.include! RoleStalker

  BOT.run
end
