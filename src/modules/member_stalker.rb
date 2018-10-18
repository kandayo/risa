# frozen_string_literal: true

module Risa
  module MemberStalker
    extend Discordrb::EventContainer

    member_join do |event|
      if member = Member[event.member.id]
        member.undelete!
      else
        Member.add(event.member)
      end
    end

    member_leave do |event|
      Member[event.user.id]&.deleted!
    end

    member_update do |event|
      next unless member = Member[event.member.id]

      member.edit(event.member)
      member.role_pks = event.member.roles.map(&:id)
    end
  end
end
