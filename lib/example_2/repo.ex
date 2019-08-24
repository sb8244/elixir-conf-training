defmodule Example2.Repo do
  use Ecto.Repo,
    otp_app: :example_2,
    adapter: Ecto.Adapters.Postgres
end
