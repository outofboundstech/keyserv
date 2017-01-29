defmodule Keyserv.User do
  use Keyserv.Web, :model

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email])
    # |> validate_length(:password, min: 8)
  end

  def registration_changeset(struct, params) do
    struct
    |> changeset(params)
    |> cast(params, [:password])
    |> validate_length(:password, min: 8, max: 127)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pwd}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pwd))
      _ ->
        changeset
    end
  end
end
