# frozen_string_literal: true

class RoleMention < Sequel::Model
  many_to_one :message
end
