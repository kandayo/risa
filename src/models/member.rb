# frozen_string_literal: true

class Member < Sequel::Model
  one_to_many :messages
  one_to_many :mentions

  many_to_many :roles, delay_pks: false

  def self.add(member)
    Member.create(
      id: member.id,
      distinct: member.distinct,
      nick: member.nick,
      avatar: member.avatar_url,
      bot: member.bot_account?,
      joined_at: member.joined_at
    )
  end

  def edit(member)
    update(
      distinct: member.distinct,
      nick: member.nick,
      avatar: member.avatar_url
    )
  end

  def deleted!
    update(deleted: true)
  end

  def undelete!
    update(deleted: false)
  end
end
