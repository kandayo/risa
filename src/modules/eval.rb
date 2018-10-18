# frozen_string_literal: true

module Risa
  module Eval
    extend Discordrb::EventContainer

    message(start_with: '!! eval') do |event|
      next unless event.user.id == ENV['DEV_ID'].to_i
      next unless code = event.message.content.match(/```ruby(.*)```/m)

      begin
        event.respond eval(code.captures.first) || '=> nil'
      rescue Exception
        event.message.react('<:wat:293825338071318529>')
      end
    end
  end
end
