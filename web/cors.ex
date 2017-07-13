defmodule Keyserv.Cors do
  use Plug.Builder

  # I may want to do something with the Sites model in the future;
  # but can any db query be cached (the query seems redundant?)
  plug CORSPlug, Application.get_env(:keyserv, Keyserv.Cors)
end
