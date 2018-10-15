# frozen_string_literal: true

class ExceptionLog < Sequel::Model
  def self.add(err)
    ExceptionLog.create(msg: err, trace: err.backtrace.join('\n'))
  end
end
