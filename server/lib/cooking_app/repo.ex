defmodule CookingApp.Repo do
  use Ecto.Repo,
    otp_app: :cooking_app,
    adapter: Ecto.Adapters.Postgres
end
