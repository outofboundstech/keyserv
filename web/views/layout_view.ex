defmodule Keyserv.LayoutView do
  use Keyserv.Web, :view

  import Phoenix.Controller, only: [get_flash: 1]

  def messages(conn) do
    msg = get_flash(conn)
    Enum.map Map.keys(msg), fn key ->
      content_tag :div, Map.fetch!(msg, key), class: "alert alert-#{key}"
    end
  end


  def nav_cls(nav, cur) do
    if nav == cur, do: "nav-link active", else: "nav-link"
  end
end
