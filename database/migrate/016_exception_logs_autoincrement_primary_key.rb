# frozen_string_literal: true

Sequel.migration do
  change do
    alter_table(:exception_logs) do
      drop_column :id
      add_primary_key :id, type: 'bigint'
    end
  end
end
