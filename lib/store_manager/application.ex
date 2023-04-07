defmodule StoreManager.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      StoreManagerWeb.Telemetry,
      # Start the Ecto repository
      StoreManager.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: StoreManager.PubSub},
      # Start Finch
      {Finch, name: StoreManager.Finch},
      # Start the Endpoint (http/https)
      StoreManagerWeb.Endpoint
      # Start a worker by calling: StoreManager.Worker.start_link(arg)
      # {StoreManager.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: StoreManager.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    StoreManagerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
