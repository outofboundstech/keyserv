defmodule Keyserv.Auth do
  import Plug.Conn

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    user_id = get_session(conn, :user_id)
    user = user_id && repo.get(Keyserv.User, user_id)
    assign(conn, :user, user)
  end

  def login(conn, user) do
    conn
    |> assign(:user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end
end
