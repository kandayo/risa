# frozen_string_literal: true

Sequel.migration do
  up do
    create_table(:roles) do
      Bignum :id, primary_key: true
      String :name, null: false
      String :colour
      DateTime :creation_time, null: false

      Integer :members_count, default: 0, null: false
    end
  end

  down do
    drop_table(:roles)
  end
end
