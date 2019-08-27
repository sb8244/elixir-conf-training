defmodule Example2.Metrics.ExampleMetricsHandler do
  require Logger

  def handle_simple([:example, :simple], measurements, metadata, config) do
    Logger.info("Handling Event [:example, :simple]")
    IO.inspect(measurements, label: "    [:example, :foo] measurements")
    IO.inspect(metadata, label: "    [:example, :foo] metadata")
    IO.inspect(config, label: "    [:example, :foo] config")

    :ok
  end
end
