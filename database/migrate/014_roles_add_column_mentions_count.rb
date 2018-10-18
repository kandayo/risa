# frozen_string_literal: true

Sequel.migration do
  change do
    alter_table(:roles) do
      add_column :mentions_count, Integer, default: 0
    end
  end
end
