defmodule Example2.Metrics.ExampleMetricsProducer do
  def emit_simple do
    :telemetry.execute([:example, :simple], %{my_data: :foo}, %{my_metadata: :bar})
  end

  def example_event do
    :telemetry.execute([:example, :foo], %{data_val_1: :rand.uniform(10), data_val_2: :rand.uniform(10)}, %{metadata_key: metadata_value()})
  end

  defp metadata_value, do: Enum.random(["metadata_value_1", "metadata_value_2", "metadata_value_3"])
end
