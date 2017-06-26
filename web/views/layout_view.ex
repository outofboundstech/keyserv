defmodule Keyserv.LayoutView do
  use Keyserv.Web, :view

  def nav_cls(nav, cur) do
    if nav == cur, do: "nav-link active", else: "nav-link"
  end
end
