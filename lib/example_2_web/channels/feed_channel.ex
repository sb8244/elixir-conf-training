defmodule Example2Web.FeedChannel do
  use Phoenix.Channel

  alias Example2.Activity
  alias Example2Web.FeedTracker

  def join("feed:" <> req_id, %{"name" => name}, socket = %{assigns: %{user_id: req_id}}) do
    {:ok, socket}
  end

  def join("feed", %{"name" => name}, socket) do
    {:ok, socket}
  end

  def join(_, _params, socket) do
    {:error, %{reason: "unauthorized"}}
  end

  # TODO(1): Use the Tracker when a Channel is joined
  # TODO(2): Track the user's name
  # def handle_info(:after_join, socket) do
  # end

  def handle_in("fetch", params, socket) do
    payload = %{activities: all_activities(params)}

    {:reply, {:ok, payload}, socket}
  end

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

  def handle_info(:remove_rate_limit, socket) do
    {:noreply, assign(socket, :rate_limited?, false)}
  end

  defp all_activities(params) do
    Activity.all(params)
  end

  defp rate_limit_socket(socket) do
    Process.send_after(self(), :remove_rate_limit, 5_000)
    assign(socket, :rate_limited?, true)
  end
end
