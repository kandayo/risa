# frozen_string_literal: true

Sequel.migration do
  up do
    create_table(:mentions) do
      primary_key :id, type: 'bigint'
      foreign_key :message_id, :messages, type: 'bigint', on_delete: :cascade
      foreign_key :member_id, :members, type: 'bigint', on_delete: :cascade

      index :message_id
      index :member_id
    end
  end

  down do
    drop_table(:mentions)
  end
end
