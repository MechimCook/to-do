# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :just_do_it, JustDoItWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "XwUXiW51x7EFQoFqh7fNpz7vcInBdnjp/tKBMUttuItwCITGBskIKgl+MM3WTVxI",
  render_errors: [view: JustDoItWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: JustDoIt.PubSub,
  live_view: [signing_salt: "di1NF6K6"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :todo, Todo.Repo,
  database: "todo_repo",
  username: "postgres",
  password: "",
  hostname: "localhost",
  port: "5432"
