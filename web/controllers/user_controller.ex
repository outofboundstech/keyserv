defmodule Keyserv.UserController do
  use Keyserv.Web, :controller
  use Keyserv.Auth, :authentication

  alias Keyserv.User

  plug :authorized?

  def index(conn, _params) do
    users = Repo.all(User)
    render conn, "index.html", defaults(conn, users: users)
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "new.html", defaults(conn, changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.registration_changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> Keyserv.Auth.login(user)
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: user_path(conn, :index))
      {:error, changeset} ->
        render conn, "new.html", defaults(conn, changeset: changeset)
    end
  end

  defp defaults(_conn, assigns \\ []) do
    assigns
    |> Keyword.put(:title, "Users")
    |> Keyword.put(:nav_link, :users)
  end
end
