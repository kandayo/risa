# frozen_string_literal: true

Sequel.migration do
  up do
    create_table(:members) do
      Bignum :id, primary_key: true
      String :distinct, null: false
      String :nick
      String :avatar
      TrueClass :bot, null: false
      DateTime :joined_at, null: false

      TrueClass :deleted, default: false, null: false

      Integer :attachments_count, default: 0, null: false
      Integer :mentionings_count, default: 0, null: false
      Integer :mentions_count, default: 0, null: false
      Integer :message_edits_count, default: 0, null: false
      Integer :messages_count, default: 0, null: false
      Integer :roles_count, default: 0, null: false
    end
  end

  down do
    drop_table(:members)
  end
end
