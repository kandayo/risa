# frozen_string_literal: true

Sequel.migration do
  change do
    alter_table(:members) do
      set_column_allow_null :joined_at
    end
  end
end
