defmodule Example2.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    attach_metrics!()

    children = [
      Example2.Repo,
      Example2Web.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Example2.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    Example2Web.Endpoint.config_change(changed, removed)
    :ok
  end

  defp attach_metrics! do
    alias Example2.Metrics.ExampleMetricsHandler

    :ok =
      :telemetry.attach(
        "simple-event",
        [:example, :simple],
        &ExampleMetricsHandler.handle_simple/4,
        %{some_config_key: :some_config_val}
      )
  end
end
