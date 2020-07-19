# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :todo_elixir,
  ecto_repos: [TodoElixir.Repo]

config :cors_plug,
  origin: ["http://localhost:3000"],
  max_age: 86400,
  methods: ["GET", "POST", "OPTIONS", "PUT", "DELETE"]

# Configures the endpoint
config :todo_elixir, TodoElixirWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "DbXVjgMEBc4baPuiwqjEoSrEgSqRb/UinTEsOYDJOFiQrJb8x9aaMb3vlJze83zg",
  render_errors: [view: TodoElixirWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: TodoElixir.PubSub,
  live_view: [signing_salt: "Txu3sj+z"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :todo_elixir, TodoElixir.Guardian,
       issuer: "todo_elixir",
       secret_key: "Cla2Co6H9lu0/U3S8ejYKNaOyIXnUsDTLHo8oce/6ULa+J3R8wSV2cNU7BQxmrHa"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
