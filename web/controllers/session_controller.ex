defmodule Keyserv.SessionController do
  use Keyserv.Web, :controller

  import Keyserv.Auth

  alias Keyserv.User

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"email" => email, "password" => pwd}}) do
    case authenticate(conn, email, pwd, repo: Repo) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Welcome, back!")
        |> redirect(to: page_path(conn, :index))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Invalid username or password")
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> logout()
    |> redirect(to: page_path(conn, :index))
  end

end
