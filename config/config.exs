# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :sidegig,
  ecto_repos: [Sidegig.Repo]

# Configures the endpoint
config :sidegig, SidegigWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "cbbX3V8f42Rj9ymKNQWuCrRYKKoCK1sR5dAQXdH6H0Ul4gqSUpEpbuLbBn0QlnAu",
  render_errors: [view: SidegigWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Sidegig.PubSub,
  live_view: [signing_salt: "vHeyyJbl"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
