# frozen_string_literal: true

class Channel < Sequel::Model
  one_to_many :messages

  def self.add(channel)
    Channel.create(
      id: channel.id,
      name: channel.name,
      topic: channel.topic,
      creation_time: channel.creation_time
    )
  end

  def edit(channel)
    update(name: channel.name, topic: channel.topic)
  end

  def deleted!
    update(deleted: true)
  end
end
