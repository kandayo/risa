# frozen_string_literal: true

Sequel.migration do
  up do
    create_table(:exception_logs) do
      Bignum :id, primary_key: true
      Text :msg, null: false
      Text :trace

      TrueClass :reviewed, default: false, null: false
      DateTime :created_at, default: Sequel.lit('now()'), null: false
    end
  end

  down do
    drop_table(:exception_logs)
  end
end
