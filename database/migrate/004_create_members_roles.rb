# frozen_string_literal: true

Sequel.migration do
  up do
    create_table(:members_roles) do
      foreign_key :member_id, :members, type: 'bigint', on_delete: :cascade
      foreign_key :role_id, :roles, type: 'bigint', on_delete: :cascade

      primary_key %i[member_id role_id]
    end
  end

  down do
    drop_table(:members_roles)
  end
end
