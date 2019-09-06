defmodule Example1.Part2.Consumer do
  use GenStage
  require Logger
  alias Example1.MockResource
  alias Example1Web.Endpoint

  def start_link(opts) do
    name = opts[:name] || __MODULE__
    subscribe_to = opts[:subscribe_to]
    resource = opts[:resource]
    GenStage.start_link(__MODULE__, %{subscribe_to: subscribe_to, resource: resource}, name: name)
  end

  def init(opts) do
    resource = opts[:resource] || MockResource
    subs = opts[:subscribe_to]
    {:consumer, %{resource: resource}, subscribe_to: subs}
  end

  def handle_events(events, _from, %{resource: resource} = state) do
    for %{event_occurred_at: start_time} <- events do
      :ok = MockResource.use_resource(resource)

      time =
        (System.monotonic_time() - start_time)
        |> System.convert_time_unit(:native, :millisecond)

      Endpoint.broadcast!("genstage_processing_times", "processing_time", %{time: time})
      Counter.decrement(EventsInSystem)
    end

    {:noreply, [], state}
  end
end
