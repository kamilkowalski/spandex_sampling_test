defmodule SpandexTest.Repo do
  use Ecto.Repo,
    otp_app: :spandex_test,
    adapter: Ecto.Adapters.Postgres
end
