defmodule Keyserv.Repo.Migrations.CreateKey do
  use Ecto.Migration

  def change do
    create table(:keys) do
      add :keyid, :string
      add :fingerprint, :string
      add :pub, :text
      add :desc, :string
      add :email, :string

      timestamps()
    end
    create unique_index(:keys, [:keyid])
    create unique_index(:keys, [:fingerprint])

  end
end
