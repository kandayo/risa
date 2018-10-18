# frozen_string_literal: true

Sequel.migration do
  change do
    alter_table(:members) do
      set_column_default :attachments_size, 0
    end
  end
end
