# frozen_string_literal: true

require 'bcrypt'

module Registration
  extend Discordrb::EventContainer

  private_message(contains: /quero me cadastrar/i) do |event|
    next unless member = Member[event.user.id]
    next if already_registered?(member)

    generate_passwd(member, event)
  end

  private_message(contains: /esqueci minha senha/i) do |event|
    next unless member = Member[event.user.id]

    generate_passwd(member, event)
  end

  def self.already_registered?(member)
    member.password_digest != nil
  end

  def self.generate_passwd(member, event)
    passwd = SecureRandom.alphanumeric(60)
    digest = BCrypt::Password.create(passwd)

    if member.update(password_digest: digest)
      event << 'Fiz uma senha temporária pra você!'
      event << passwd
      event << 'Não se esqueça de alterá-la, tá?'
    end
  end
end
