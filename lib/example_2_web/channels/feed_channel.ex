defmodule Example2Web.FeedChannel do
  use Phoenix.Channel

  alias Example2.Activity

  def join("feed", _params, socket) do
    {:ok, socket}
  end

  def handle_in("fetch", params, socket) do
    payload = %{activities: all_activities(params)}

    {:reply, {:ok, payload}, socket}
  end

  # When the rate_limited? state is set to true, you cannot create new activities
  def handle_in("create_activity", _params, socket = %{assigns: %{rate_limited?: true}}) do
    {:reply, {:error, %{err: "rate limit exceeded"}}, socket}
  end

  def handle_in("create_activity", params, socket) do
    params
    |> Map.put("occurred_at", DateTime.utc_now())
    |> Activity.create()
    |> case do
      {:ok, activity} ->
        {:reply, {:ok, activity}, rate_limit_socket(socket)}

      {:error, _err} ->
        {:reply, {:error, %{err: "invalid activity data"}}, socket}
    end
  end

  # TODO (2b): You will see an error in your GenServer once you start sending yourself a message. Implement a
  # handle_info here in order to remove the rate limiting from the socket.
  def handle_info(:remove_rate_limit, socket) do
    {:noreply, assign(socket, :rate_limited?, false)}
  end

  defp all_activities(params) do
    Activity.all(params)
  end

  defp rate_limit_socket(socket) do
    # TODO (2a): You're going to mark the socket as rate limited, but you should also line up the removal of
    # that rate limit for 5 seconds in the future. Do this by sending your `self` a message.
    Process.send_after(self(), :remove_rate_limit, 5_000)

    # TODO (1): The socket is being returned without modification. Leverage Channel state in order to
    # mark this socket as rate limited
    assign(socket, :rate_limited?, true)
  end
end
