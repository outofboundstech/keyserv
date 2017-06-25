defmodule Keyserv.KeyController do
  use Keyserv.Web, :controller

  alias Keyserv.Key

  plug :authorized?
  plug :put_layout, "legacy.html"

  defp authorized?(conn, _opts) do
    if conn.assigns.user do
      conn
    else
      conn
      |> put_flash(:error, "You must be signed in to access that page")
      |> redirect(to: page_path(conn, :index))
      |> halt()
    end
  end

  def index(conn, _params) do
    keys = Repo.all(Key)
    render(conn, "index.html", keys: keys)
  end

  def new(conn, _params) do
    changeset = Key.changeset(%Key{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"key" => key_params}) do
    changeset = Key.changeset(%Key{}, key_params)

    case Repo.insert(changeset) do
      {:ok, _key} ->
        conn
        |> put_flash(:info, "Key created successfully.")
        |> redirect(to: key_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    key = Repo.get!(Key, id)
    render(conn, "show.html", key: key)
  end

  def edit(conn, %{"id" => id}) do
    key = Repo.get!(Key, id)
    changeset = Key.changeset(key)
    render(conn, "edit.html", key: key, changeset: changeset)
  end

  def update(conn, %{"id" => id, "key" => key_params}) do
    key = Repo.get!(Key, id)
    changeset = Key.changeset(key, key_params)

    case Repo.update(changeset) do
      {:ok, key} ->
        conn
        |> put_flash(:info, "Key updated successfully.")
        |> redirect(to: key_path(conn, :show, key))
      {:error, changeset} ->
        render(conn, "edit.html", key: key, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    key = Repo.get!(Key, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(key)

    conn
    |> put_flash(:info, "Key deleted successfully.")
    |> redirect(to: key_path(conn, :index))
  end
end
