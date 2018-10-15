# frozen_string_literal: true

Sequel.migration do
  up do
    create_table(:channels) do
      Bignum :id, primary_key: true
      String :name, null: false
      String :topic
      DateTime :creation_time, null: false

      TrueClass :deleted, default: false, null: false

      Integer :attachments_count, default: 0, null: false
      Integer :attachments_size, default: 0, null: false
      Integer :message_edits_count, default: 0, null: false
      Integer :messages_count, default: 0, null: false
    end
  end

  down do
    drop_table(:channels)
  end
end
