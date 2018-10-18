# frozen_string_literal: true

module Risa
  module Eval
    extend Discordrb::EventContainer

    message(start_with: '!! eval') do |event|
      break unless event.user.id == ENV['DEV_ID']
      break unless code = event.message.content.match(/```ruby(.*)```/m)&[1]

      begin
        eval(code.strip)
      rescue
        event.message.react('<:wat:293825338071318529>')
      end
    end
  end
end
