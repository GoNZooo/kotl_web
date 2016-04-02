# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the namespace used by Phoenix generators
config :kotl_web,
  app_namespace: KOTLWeb

# Configures the endpoint
config :kotl_web, KOTLWeb.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "RX2Vh37CdhFzPekvaMspuk3M/N5EL4Lnp4cIcUD0+R3/NtUA/BDWmYmK+9FtmrFm",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: KOTLWeb.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false
