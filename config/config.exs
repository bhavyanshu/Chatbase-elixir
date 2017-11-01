# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :chatbase, api_key: System.get_env("CHATBASE_API_KEY")
