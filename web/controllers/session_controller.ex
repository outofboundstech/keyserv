defmodule Keyserv.SessionController do
  use Keyserv.Web, :controller

  alias Keyserv.User

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"email" => email, "password" => pwd}}) do

  end


end
