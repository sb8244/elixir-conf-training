defmodule Example2Web.FeedChannel do
  use Phoenix.Channel

  alias Example2.{Activity, RateLimit}

  def join("feed", _params, socket) do
    {:ok, socket}
  end

  def handle_in("fetch", params, socket) do
    payload = %{activities: all_activities(params)}

    {:reply, {:ok, payload}, socket}
  end

  def handle_in("create_activity", params, socket) do
    with {:ok, :open} <- RateLimit.cas_rate_limit(),
         params <- Map.put(params, "occurred_at", DateTime.utc_now()),
         {:ok, activity} <- Activity.create(params) do
      {:reply, {:ok, activity}, socket}
    else
      {:ok, :rate_limited} ->
        {:reply, {:error, %{err: "rate limit exceeded"}}, socket}

      {:error, _err} ->
        {:reply, {:error, %{err: "invalid activity data"}}, socket}
    end
  end

  defp all_activities(params) do
    Activity.all(params)
  end
end
