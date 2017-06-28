defmodule Keyserv.KeyController do
  use Keyserv.Web, :controller
  use Keyserv.Auth, :authentication

  alias Keyserv.Key

  plug :authorized?

  def index(conn, _params) do
    keys = Repo.all(Key)
    render conn, "index.html", defaults(conn, keys: keys)
  end

  def new(conn, _params) do
    changeset = Key.changeset(%Key{})
    render conn, "new.html", defaults(conn, changeset: changeset)
  end

  def create(conn, %{"key" => key_params}) do
    changeset = Key.changeset(%Key{}, key_params)

    case Repo.insert(changeset) do
      {:ok, _key} ->
        conn
        |> put_flash(:success, "Key created successfully.")
        |> redirect(to: key_path(conn, :index))
      {:error, changeset} ->
        render conn, "new.html", defaults(conn, changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    key = Repo.get!(Key, id)
    changeset = Key.changeset(key)
    render conn, "edit.html", defaults(conn, key: key, changeset: changeset)
  end

  def update(conn, %{"id" => id, "key" => key_params}) do
    key = Repo.get!(Key, id)
    changeset = Key.changeset(key, key_params)

    case Repo.update(changeset) do
      {:ok, key} ->
        conn
        |> put_flash(:success, "Key updated successfully.")
        |> redirect(to: key_path(conn, :show, key))
      {:error, changeset} ->
        render conn, "edit.html", defaults(conn, key: key, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    key = Repo.get!(Key, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(key)

    conn
    |> put_flash(:success, "Key deleted successfully.")
    |> redirect(to: key_path(conn, :index))
  end

  defp defaults(conn, assigns \\ []) do
    assigns
    |> Keyword.put(:title, "Public keys")
    |> Keyword.put(:nav_link, :keys)
  end
end
