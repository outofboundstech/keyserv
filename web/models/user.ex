defmodule Keyserv.User do
  use Keyserv.Web, :model

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
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
    |> cast(params, [:password, :password_confirmation])
    |> unique_constraint(:email)
    |> validate_length(:password, min: 8, max: 127)
    |> validate_confirmation(:password)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pwd}} ->
        # Refactor all decisions on passwords and hashing to auth.ex
        put_change(changeset, :password_hash, Keyserv.Auth.prepare_pwd(pwd))
      _ ->
        changeset
    end
  end
end
