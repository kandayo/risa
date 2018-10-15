# frozen_string_literal: true

Sequel.migration do
  up do
    create_table(:attachments) do
      foreign_key :message_id, :messages, type: 'bigint', on_delete: :cascade

      Bignum :id, primary_key: true
      String :filename
      String :url
      Integer :size
    end
  end

  down do
    drop_table(:attachments)
  end
end
