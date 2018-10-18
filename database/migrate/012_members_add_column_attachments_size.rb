# frozen_string_literal: true

Sequel.migration do
  change do
    alter_table(:members) do
      add_column :attachments_size, 'bigint'
    end
  end
end
