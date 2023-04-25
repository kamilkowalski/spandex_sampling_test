defmodule SpandexTest.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      SpandexTestWeb.Telemetry,
      # Start the Ecto repository
      SpandexTest.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: SpandexTest.PubSub},
      # Start Finch
      {Finch, name: SpandexTest.Finch},
      # Start the Endpoint (http/https)
      SpandexTestWeb.Endpoint
      # Start a worker by calling: SpandexTest.Worker.start_link(arg)
      # {SpandexTest.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SpandexTest.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SpandexTestWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
