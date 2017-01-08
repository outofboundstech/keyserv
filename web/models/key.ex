defmodule Keyserv.Key do
  use Keyserv.Web, :model

  @derive {Poison.Encoder, only: [:keyid, :fingerprint, :desc]}
  schema "keys" do
    field :keyid, :string
    field :fingerprint, :string
    field :pub, :string
    field :desc, :string
    field :email, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:keyid, :fingerprint, :pub, :desc, :email])
    |> validate_required([:keyid, :fingerprint, :pub, :desc, :email])
    |> unique_constraint(:keyid)
    |> unique_constraint(:fingerprint)
  end
end
