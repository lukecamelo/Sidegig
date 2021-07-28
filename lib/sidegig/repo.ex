defmodule Sidegig.Repo do
  use Ecto.Repo,
    otp_app: :sidegig,
    adapter: Ecto.Adapters.Postgres
end
