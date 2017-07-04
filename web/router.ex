defmodule Keyserv.Router do
  use Keyserv.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Keyserv.Auth, repo: Keyserv.Repo
  end

  pipeline :api do
    plug Keyserv.Cors
    plug :accepts, ["json"]
  end

  scope "/", Keyserv do
    pipe_through :browser # Use the default browser stack

    resources "/keys", KeyController, except: [:show]
    resources "/users", UserController, only: [:index, :new, :create]
    resources "/session", SessionController, only: [:new, :create, :delete]

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", Keyserv do
    pipe_through :api

    post "/mail/deliver", Mailman, :deliver
    options "/mail/deliver", Mailman, :options
  end

  scope "/api", Keyserv.API do
    pipe_through :api

    get "/keys", KeyController, :index
    get "/keys/:fingerprint", KeyController, :show

    post "/keys/report", KeyController, :report
  end
end
