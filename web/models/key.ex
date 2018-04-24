defmodule Keyserv.Key do
  use Keyserv.Web, :model

  @derive {Poison.Encoder, only: [:fingerprint, :desc, :default]}
  schema "keys" do
    field :fingerprint, :string
    field :pub, :string
    field :desc, :string
    field :email, :string
    field :default, :boolean

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:fingerprint, :pub, :desc, :email, :default])
    |> validate_required([:fingerprint, :pub, :desc, :email])
    |> unique_constraint(:fingerprint)
  end

  # Public api

  def as_phrase(key), do: ~s(\"#{key.desc}\" <#{key.email}>)

end
