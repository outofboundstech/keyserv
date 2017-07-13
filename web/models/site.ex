defmodule Keyserv.Site do
  use Keyserv.Web, :model

  schema "sites" do
    field :name, :string
    field :hostname, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :hostname])
    |> validate_required([:name, :hostname])
  end
end
