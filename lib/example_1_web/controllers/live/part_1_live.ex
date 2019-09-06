defmodule Example1Web.Part1Live do
  use Phoenix.LiveView
  alias Example1.MockResource

  def render(assigns) do
    ~L"""
    <div class="page flex-center">
      <div class="guage three-d-shadow">
        <div class="title flex-center"><h1>Concurrent Requests to Mock Resource</h1></div>
        <div class="content flex-center"><h2><%= @average %></h2></div>
      </div>
    </div>
    """
  end

  def mount(_session, socket) do
    :timer.send_interval(20, self(), :tick)

    {:ok, put_count(socket)}
  end

  def handle_info(:tick, socket), do: {:noreply, put_count(socket)}

  def put_count(socket) do
    samples = (socket.assigns[:samples] || []) |> Enum.take(10)
    samples = [MockResource.current_requests() | samples]
    average = (Enum.sum(samples) / length(samples)) |> Float.round(2)
    assign(socket, average: average, samples: samples)
  end
end
