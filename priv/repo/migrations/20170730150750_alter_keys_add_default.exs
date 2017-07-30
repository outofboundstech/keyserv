defmodule Keyserv.Repo.Migrations.UpdateKeysTable do
  use Ecto.Migration

  def change do

    alter table(:keys) do
      add :default, :boolean, default: fragment("FALSE")
    end

  end
end
