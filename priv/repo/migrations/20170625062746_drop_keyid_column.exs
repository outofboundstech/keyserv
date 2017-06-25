defmodule Keyserv.Repo.Migrations.DropKeyidColumn do
  use Ecto.Migration

  def change do
    alter table(:keys) do
      remove :keyid
    end

    # It seems the index is automatically dropped when the column is dropped?
  end
end
