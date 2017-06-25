defmodule Keyserv.API.KeyController do
  use Keyserv.Web, :controller

  alias Keyserv.Key

  def index(conn, _params) do
    keys = Repo.all(Key)
    json conn, %{keys: keys}
  end

  def show(conn, %{"fingerprint" => fingerprint}) do
    # Are my parameters clean?
    # Throws Ecto.NoResultError
    key = Repo.get_by!(Key, fingerprint: fingerprint)
    text conn, key.pub
  end

  def report(conn, params) do
    # This is a stub
    inspect(params)
    text conn, "Ok"
  end

end
