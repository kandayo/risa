# frozen_string_literal: true

class Role < Sequel::Model
  many_to_many :members

  def self.add(role)
    Role.create(
      id: role.id,
      name: role.name,
      colour: role.colour.combined,
      creation_time: role.creation_time
    )
  end

  def edit(role)
    update(name: role.name, colour: role.colour.combined)
  end
end
