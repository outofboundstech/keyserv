defmodule Keyserv.PageController do
  use Keyserv.Web, :controller
  use Keyserv.Auth, :authentication

  plug :authorized?

  def index(conn, _params) do
    render conn, "index.html", defaults(conn)
  end

  defp defaults(conn, assigns \\ []) do
    assigns
    |> Keyword.put(:title, "Dashboard")
    |> Keyword.put(:nav_link, :dashboard)
  end
end
