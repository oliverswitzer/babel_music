defmodule BabelMusic.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      BabelMusicWeb.Telemetry,
      # Start the Ecto repository
      BabelMusic.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: BabelMusic.PubSub},
      # Start Finch
      {Finch, name: BabelMusic.Finch},
      # Start the Endpoint (http/https)
      BabelMusicWeb.Endpoint
      # Start a worker by calling: BabelMusic.Worker.start_link(arg)
      # {BabelMusic.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BabelMusic.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BabelMusicWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
