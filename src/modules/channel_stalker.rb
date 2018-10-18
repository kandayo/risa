# frozen_string_literal: true

module Risa
  module ChannelStalker
    extend Discordrb::EventContainer

    channel_create do |event|
      next if event.channel.private?
      Channel.add(event.channel)
    end

    channel_update do |event|
      next if event.channel.private?
      Channel[event.channel.id]&.edit(event.channel)
    end

    channel_delete do |event|
      next if event.channel.private?
      Channel[event.id]&.deleted!
    end
  end
end
