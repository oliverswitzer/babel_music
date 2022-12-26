defmodule BabelMusic.Repo do
  use Ecto.Repo,
    otp_app: :babel_music,
    adapter: Ecto.Adapters.Postgres
end
