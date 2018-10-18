# frozen_string_literal: true

Sequel.migration do
  up do
    create_table(:role_mentions) do
      primary_key :id, type: 'bigint'
      foreign_key :message_id, :messages, type: 'bigint', on_delete: :cascade
      foreign_key :role_id, :roles, type: 'bigint', on_delete: :cascade

      index :message_id
      index :role_id
    end
  end

  down do
    drop_table(:role_mentions)
  end
end
