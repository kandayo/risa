# frozen_string_literal: true

module Risa
  module MessageStalker
    extend Discordrb::EventContainer

    message do |event|
      Message.add(event.message)
    end

    message_edit do |event|
      Message[event.message.id]&.edit(event.message)
    end

    message_delete do |event|
      Message[event.id]&.wipe
    end
  end
end
