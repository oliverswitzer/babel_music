# Babel Music

An app for converting apple playlists to spotify playlists and vice versa

## Development

1. `mix deps.get`
1. `npm i --prefix assets`
1. Update Spotify API creds to allow your personal ngrok redirect_uri ("https://<ngrok url>/users/spotify/callback")
1. Update dev.exs to use said redirect_uri:

```
config :spotify_ex,
  callback_url: "https://<ngrok url>/users/spotify/callback"
```

1. `mix phx.server`
