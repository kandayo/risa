# frozen_string_literal: true

module Bootstrap
  extend Discordrb::EventContainer

  ready do |event|
    next unless server = event.bot.server(ENV['SERVER'])

    server.channels.each do |channel|
      next if Channel[channel.id]
      Channel.add(channel)
    end

    server.roles.each do |role|
      next if Role[role.id]
      Role.add(role)
    end

    server.members.each do |member|
      next if Member[member.id]
      Member.add(member)
    end
  end
end
