defmodule Example2Web.FeedChannel do
  use Phoenix.Channel

  def join("feed", _params, socket) do
    {:ok, socket}
  end

  def handle_in("fetch", params, socket) do
    {:reply, {:ok, %{activities: all_activities(params)}}, socket}
  end

  defp all_activities(params) do
    Example2.Activity.all(params)
  end
end
