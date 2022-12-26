defmodule BabelMusicWeb.AuthorizationController do
  use BabelMusicWeb, :controller

  def authorize(conn, _params) do
    redirect(conn, external: Spotify.Authorization.url())
  end

  def callback(conn, params) do
    case Spotify.Authentication.authenticate(conn, params) do
      {:ok, conn} ->
        IO.puts("SUCCESS")
        redirect(conn, to: "/playlist-converter")

      {:error, _reason, conn} ->
        redirect(conn, to: "/error")
    end
  end
end
