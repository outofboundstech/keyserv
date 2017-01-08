defmodule Keyserv.PageController do
  use Keyserv.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
