defmodule Keyserv.Router do
  use Keyserv.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Keyserv do
    pipe_through :browser # Use the default browser stack

    resources "/keys", KeyController

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", Keyserv.API do
    pipe_through :api

    get "/keys", KeyController, :index
    get "/keys/:fingerprint", KeyController, :show

    post "/keys/report", KeyController, :report
  end

  scope "/api", Keyserv do
    pipe_through :api

    post "/mail/deliver", Mailman, :deliver
  end
end
