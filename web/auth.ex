defmodule Keyserv.Auth do
  import Plug.Conn

  import Comeonin.Bcrypt

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    user_id = get_session(conn, :user_id)
    user = user_id && repo.get(Keyserv.User, user_id)
    assign(conn, :user, user)
  end

  def authenticate(conn, email, pwd, opts) do
    repo = Keyword.fetch!(opts, :repo)
    user = repo.get_by(Keyserv.User, email: email)

    cond do
      user && checkpw(pwd, user.password_hash) ->
        {:ok, login(conn, user)}
      user ->
        {:error, :unauthorized, conn}
      true ->
        dummy_checkpw()
        {:error, :not_found, conn}
    end
  end

  def login(conn, user) do
    conn
    |> assign(:user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  def logout(conn) do
    configure_session(conn, drop: true)
  end

  def prepare_pwd(pwd) do
    hashpwsalt(pwd)
  end
end
