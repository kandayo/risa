# frozen_string_literal: true

Sequel.migration do
  change do
    alter_table(:channels) do
      set_column_type :attachments_size, 'bigint'
    end
  end
end
