# frozen_string_literal: true

Sequel.migration do
  up do
    create_table(:messages) do
      foreign_key :channel_id, :channels, type: 'bigint', on_delete: :cascade
      foreign_key :member_id, :members, type: 'bigint', on_delete: :cascade

      Bignum :id, primary_key: true
      Text :content
      DateTime :timestamp, null: false
      DateTime :edited_timestamp
      TrueClass :mention_everyone

      index :channel_id
      index :member_id
      index :timestamp
    end
  end

  down do
    drop_table(:messages)
  end
end
