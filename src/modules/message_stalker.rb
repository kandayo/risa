# frozen_string_literal: true

module Risa
  module MessageStalker
    extend Discordrb::EventContainer

    message do |event|
      next if event.channel.private?
      Message.add(event.message)
    end

    message_edit do |event|
      next if event.channel.private?
      Message[event.message.id]&.edit(event.message)
    end

    message_delete do |event|
      next if event.channel.private?
      Message[event.id]&.wipe
    end
  end
end
