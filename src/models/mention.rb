# frozen_string_literal: true

class Mention < Sequel::Model
  many_to_one :message
end
