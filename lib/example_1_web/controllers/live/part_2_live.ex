defmodule Example1Web.Part2Live do
  use Phoenix.LiveView
  alias Example1.MockResource
  alias Example1Web.Endpoint

  def render(assigns) do
    ~L"""
    <div class="page flex-center">
      <div class="guage three-d-shadow">
        <div class="title flex-center"><h1>Enqueued Events</h1></div>
        <div class="content flex-center"><h2><%= @queue_depth %></h2></div>
      </div>

      <div class="guage three-d-shadow">
        <div class="title flex-center"><h1>Concurrent Resource Usage</h1></div>
        <div class="content flex-center"><h2><%= @resource_average %></h2></div>
      </div>

      <div class="guage three-d-shadow">
        <div class="title flex-center"><h1>Average Processing Time (ms)</h1></div>
        <div class="content flex-center"><h2><%= @processing_time_avg %></h2></div>
      </div>
    </div>
    """
  end

  def mount(_session, socket) do
    :timer.send_interval(20, self(), :tick)

    if connected?(socket) do
      Endpoint.subscribe("genstage_processing_times")
    end

    socket =
      assign(socket, %{
        processing_time_avg: 0,
        resource_samples: [],
        processing_time_samples: []
      })

    {:ok, put_count(socket)}
  end

  def handle_info(
        %{event: "processing_time", topic: "genstage_processing_times", payload: %{time: time}},
        socket
      ) do
    processing_time_samples = [time | socket.assigns[:processing_time_samples]]

    {:noreply,
     assign(socket,
       processing_time_avg: average(processing_time_samples),
       processing_time_samples: processing_time_samples
     )}
  end

  def handle_info(:tick, socket), do: {:noreply, put_count(socket)}

  def put_count(socket) do
    resource_samples = socket.assigns[:resource_samples] |> Enum.take(10)
    resource_samples = [MockResource.current_requests() | resource_samples]

    assign(socket,
      queue_depth: Counter.value(EventsInSystem),
      resource_average: average(resource_samples),
      resource_samples: resource_samples
    )
  end

  defp average(samples), do: (Enum.sum(samples) / length(samples)) |> Float.round(0)
end
