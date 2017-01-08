# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :keyserv,
  ecto_repos: [Keyserv.Repo]

# Configures the endpoint
config :keyserv, Keyserv.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "VllaeT97mXiI0dk7VH3fup04R6UQxuUqoqfBZnoGeFjWJ/shPLxmr76tm7pYaw9N",
  render_errors: [view: Keyserv.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Keyserv.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
