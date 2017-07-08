defmodule Keyserv.Repo.Migrations.CreateSite do
  use Ecto.Migration

  def change do
    create table(:sites) do
      add :name, :string
      add :hostname, :string

      timestamps()
    end

  end
end
