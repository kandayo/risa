# frozen_string_literal: true

class Message < Sequel::Model
  many_to_one :channel
  many_to_one :member
  one_to_many :attachments
  one_to_many :mentions

  def self.add(message)
    msg = Message.create(
      id: message.id,
      channel_id: message.channel.id,
      member_id: message.author.id,
      content: message.content,
      edited_timestamp: message.edited_timestamp,
      mention_everyone: message.mention_everyone?,
      timestamp: message.timestamp
    )

    message.mentions.each do |mention|
      msg&.add_mention(member_id: mention.id)
    end

    message.attachments.each do |attachment|
      msg&.add_attachment({
        id: attachment.id,
        filename: attachment.filename,
        url: attachment.url,
        size: attachment.size
      })
    end
  end

  def edit(message)
    update(
      content: message.content,
      edited_timestamp: message.edited_timestamp
    )
  end

  def wipe
    attachments.each(&:delete)
    mentions.each(&:delete)
    delete
  end
end
