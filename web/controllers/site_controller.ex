defmodule Keyserv.SiteController do
  use Keyserv.Web, :controller

  alias Keyserv.Site

  def index(conn, _params) do
    sites = Repo.all(Site)
    render conn, "index.html", defaults(conn, sites: sites)
  end

  def new(conn, _params) do
    changeset = Site.changeset(%Site{})
    render conn, "new.html", defaults(conn, changeset: changeset)
  end

  def create(conn, %{"site" => site_params}) do
    changeset = Site.changeset(%Site{}, site_params)

    case Repo.insert(changeset) do
      {:ok, _site} ->
        conn
        |> put_flash(:info, "Site created successfully.")
        |> redirect(to: site_path(conn, :index))
      {:error, changeset} ->
        render conn, "new.html", defaults(conn, changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    site = Repo.get!(Site, id)
    changeset = Site.changeset(site)
    render conn, "edit.html", defaults(conn, site: site, changeset: changeset)
  end

  def update(conn, %{"id" => id, "site" => site_params}) do
    site = Repo.get!(Site, id)
    changeset = Site.changeset(site, site_params)

    case Repo.update(changeset) do
      {:ok, _site} ->
        conn
        |> put_flash(:info, "Site updated successfully.")
        |> redirect(to: site_path(conn, :index))
      {:error, changeset} ->
        render conn, "edit.html", defaults(conn, site: site, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    site = Repo.get!(Site, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(site)

    conn
    |> put_flash(:info, "Site deleted successfully.")
    |> redirect(to: site_path(conn, :index))
  end

  defp defaults(_conn, assigns \\ []) do
    assigns
    |> Keyword.put(:title, "Sites")
    |> Keyword.put(:nav_link, :sites)
  end
end
