# frozen_string_literal: true

module ChannelStalker
  extend Discordrb::EventContainer

  channel_create do |event|
    Channel.add(event.channel)
  end

  channel_update do |event|
    Channel[event.channel.id]&.edit(event.channel)
  end

  channel_delete do |event|
    Channel[event.id]&.deleted!
  end
end
