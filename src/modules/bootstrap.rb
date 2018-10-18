# frozen_string_literal: true

module Bootstrap
  extend Discordrb::EventContainer

  ready do |event|
    next unless server = event.bot.server(ENV['SERVER'])

    server.roles.each do |_|
      update Role, _
    end

    server.members.each do |_|
      update Member, _
    end

    server.text_channels.each do |_|
      update Channel, _
      fetch_unstalked_messages _
    end
  end

  # Do not use it to iterate over an entire channel.
  #
  def self.fetch_unstalked_messages(channel)
    last_id = nil

    loop do
      messages = channel.history(100, last_id)

      messages.each do |message|
        Message.add(message)
      end

      break if messages.size < 100

      last_id = messages.last.id
    end
  rescue Sequel::UniqueConstraintViolation
    nil
  end

  def self.update(klass, resource)
    if item = klass[resource.id]
      item.edit(resource)
    else
      klass.add(resource)
    end
  end
end
