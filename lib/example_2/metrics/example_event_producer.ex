defmodule Example2.Metrics.ExampleMetricsProducers do
  def emit_simple do
    :telemetry.execute([:example, :simple], %{some_payload_key: :bar}, %{some_metadata_key: :baz})
  end

  def emit_counter(count \\ 1) do
    :telemetry.execute([:example, :example_counter], %{elixir_fans: count})
  end

  def emit_sum(count \\ 1) do
    :telemetry.execute([:example, :example_sum], %{elixir_fans: count})
  end
end
