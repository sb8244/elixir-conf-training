# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :example_1, Example1Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "y+iX5eErhPSRIL2w75WiJoiQGowQllO4OcMSD6XEAQWNBiJ+Ae3V5gm3F3YF6swA",
  render_errors: [view: Example1Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Example1.PubSub, adapter: Phoenix.PubSub.PG2]

config :example_1, Example1Web.Endpoint,
  live_view: [
    signing_salt: "SECRET_SALT"
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
