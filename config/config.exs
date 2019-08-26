# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :example_2,
  ecto_repos: [Example2.Repo]

# Configures the endpoint
config :example_2, Example2Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "EiENYIqw2BeRJrHp1vpVoqeiezpLlDOgNFH1VNJAu+mC6gAWMssEnvcP44+mb294",
  render_errors: [view: Example2Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Example2.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "GgDcwY1fw6yWrNvBCJOpeArmIL35EQWp"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
