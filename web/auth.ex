defmodule Keyserv.Auth do

  import Plug.Conn
  import Comeonin.Bcrypt

  alias Keyserv.User

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    user_id = get_session(conn, :user_id)
    # Is it worth assigning :user_id to conn and defer the repo.get call
    # until it's absolutely necessary?
    user = user_id && repo.get(User, user_id)
    assign(conn, :user, user)
  end

  def authentication do
    quote do
      def authorized?(conn, _opts) do
        if conn.assigns.user do
          conn
        else
          conn
          |> redirect(to: session_path(conn, :new))
          |> halt()
        end
      end
    end
  end

  def authenticate(conn, email, pwd, opts) do
    repo = Keyword.fetch!(opts, :repo)
    user = repo.get_by(User, email: email)

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

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
