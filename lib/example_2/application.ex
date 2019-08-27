defmodule Example2.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    attach_manual_metrics!()

    children = [
      Example2.Repo,
      Example2Web.Endpoint,
      {Telemetry.Metrics.ConsoleReporter, metrics: metrics()}
    ]

    opts = [strategy: :one_for_one, name: Example2.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    Example2Web.Endpoint.config_change(changed, removed)
    :ok
  end

  defp attach_manual_metrics! do
    alias Example2.Metrics.ExampleMetricsHandler

    :ok =
      :telemetry.attach(
        "simple-event",
        [:example, :simple],
        &ExampleMetricsHandler.handle_simple/4,
        %{some_config_key: :some_config_val}
      )
  end

  defp metrics do
    import Telemetry.Metrics

    [
      counter("example.example_counter"),
      distribution("example.example_distribution", buckets: [100, 200, 300]),
      last_value("example.example_last_value"),
      sum("example.example_sum"),
      summary("example.example_summary")
    ]
  end
end
