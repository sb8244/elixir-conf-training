defmodule Example2Web.FeedTracker do
  @behaviour Phoenix.Tracker

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]},
      type: :supervisor
    }
  end

  def start_link(opts) do
    opts =
      opts
      |> Keyword.put(:name, __MODULE__)
      |> Keyword.put(:pubsub_server, Example2.PubSub)

    Phoenix.Tracker.start_link(__MODULE__, opts, opts)
  end

  def init(opts) do
    server = Keyword.fetch!(opts, :pubsub_server)
    {:ok, %{pubsub_server: server, node_name: Phoenix.PubSub.node_name(server)}}
  end

  def track(%Phoenix.Socket{topic: topic, channel_pid: pid, id: id}, name) do
    Phoenix.Tracker.track(__MODULE__, pid, topic, id, %{
      online_at: :erlang.system_time(:millisecond),
      name: name
    })
  end

  # Check for either feed:123 or feed here. You will see connected IDs in the JavaScript console or on the server logs.
  def listeners?(topic) do
    Phoenix.Tracker.list(__MODULE__, topic)
    |> Enum.any?()
  end

  def handle_diff(diff, state) do
    # TODO(3): Print the join/leave items together
    IO.inspect {"Diff received", diff, state}
    {:ok, state}
  end
end
