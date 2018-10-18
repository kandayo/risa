# frozen_string_literal: true

module Risa
  module CommitInfo
    extend Discordrb::EventContainer

    mention do |event|
      next unless event.channel.private?

      event.user.pm <<~CODE
        ```diff
        #{`git show --pretty=%H`}
        ```
      CODE
    end
  end
end
