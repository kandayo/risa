# frozen_string_literal: true

module RoleStalker
  extend Discordrb::EventContainer

  server_role_create do |event|
    Role.add(event.role)
  end

  server_role_update do |event|
    Role[event.role.id]&.edit(event.role)
  end

  server_role_delete do |event|
    Role[event.id]&.delete
  end
end
