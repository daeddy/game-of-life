import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :game_of_life, GameOfLifeWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "K6l9rhbx2LxyoRv1aQN0Cx0PFHMzAgMC/GQ+/kZTqZQexTpuGzT3Fhb6ZJEfsz7G",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
