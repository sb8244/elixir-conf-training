defmodule Example2.Metrics.ExampleMetricsProducers do
  def emit_simple do
    :telemetry.execute([:example, :simple], %{some_payload_key: :bar}, %{some_metadata_key: :baz})
  end
end
