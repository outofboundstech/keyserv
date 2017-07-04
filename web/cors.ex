defmodule Keyserv.Cors do
  use Plug.Builder

  # Dynamically assign origin
  plug CORSPlug, origin: ["http://localhost:4000", "http://localhost:3333"]
end
