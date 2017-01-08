defmodule Keyserv.API.KeyController do
  use Keyserv.Web, :controller

  alias Keyserv.Key

  def index(conn, _params) do
    keys = Repo.all(Key)
    json conn, %{keys: keys}
  end

  def show(conn, %{"fingerprint" => fingerprint}) do
    # Are by parameters clean?
    # Throws Ecto.NoResultError
    key = Repo.get_by!(Key, fingerprint: fingerprint)
    text conn, key.pub
  end

end
