defmodule BabelMusicWeb.PlaylistConverterLive do
  use BabelMusicWeb, :live_view

  def mount(_params, session, socket) do
    with spotify_creds <- Map.get(session, "spotify_credentials"),
         {:ok, spotify_profile} <- Spotify.Profile.me(spotify_creds),
         {:ok, user_playlists} <-
           Spotify.Playlist.get_users_playlists(spotify_creds, spotify_profile.id) do
      socket
      |> assign(:playlists, user_playlists)
      |> assign(:spotify_profile, spotify_profile)
      |> ok()
    else
      # TODO: Figure out how to handle error case
      _e ->
        _e
    end
  end

  def render(assigns) do
    ~H"""
    <h1 class="text-2xl">Hi, <%= @spotify_profile.display_name %>!</h1>
    <h2 class="text-lg text-slate-400">Here are all of your playlists</h2>
    <.table id="playlists" rows={@playlists.items}>
      <:col :let={playlist} label="name"><%= playlist.name %></:col>
      <:col :let={playlist} label="description"><%= playlist.description %></:col>
    </.table>
    """
  end

  defp ok(socket), do: {:ok, socket}
end
