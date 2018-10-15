# frozen_string_literal: true

class Attachment < Sequel::Model
  many_to_one :message
end
