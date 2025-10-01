defmodule SuperApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      SuperAppWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:super_app, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: SuperApp.PubSub},
      # Start a worker by calling: SuperApp.Worker.start_link(arg)
      # {SuperApp.Worker, arg},
      # Start to serve requests, typically the last entry
      SuperAppWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SuperApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SuperAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
