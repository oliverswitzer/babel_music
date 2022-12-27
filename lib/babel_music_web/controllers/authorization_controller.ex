defmodule BabelMusicWeb.AuthorizationController do
  use BabelMusicWeb, :controller

  def authorize(conn, _params) do
    redirect(conn, external: Spotify.Authorization.url()
  end

  def callback(conn, params) do
    case Spotify.Authentication.authenticate(conn, params) do
      {:ok, conn} ->
        conn =
          conn
          |> Plug.Conn.put_session(
            "spotify_credentials",
            spotify_credentials(conn)
          )

        redirect(conn, to: "/playlist-converter")

      {:error, _reason, conn} ->
        redirect(conn, to: "/error")
    end
  end

  defp spotify_credentials(conn) do
    access_token = get_req_cookie(conn, "spotify_access_token")
    refresh_token = get_req_cookie(conn, "spotify_refresh_token")
    Spotify.Credentials.new(access_token, refresh_token)
  end

  defp get_req_cookie(conn, name) do
    Plug.Conn.get_req_header(conn, "cookie")
    |> List.first()
    |> Plug.Conn.Cookies.decode()
    |> Map.get(name)
  end
end
