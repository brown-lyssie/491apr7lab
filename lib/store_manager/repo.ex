defmodule StoreManager.Repo do
  use Ecto.Repo,
    otp_app: :store_manager,
    adapter: Ecto.Adapters.Postgres
end
