defmodule Example2Web.FeedSocket do
  use Phoenix.Socket

  ## Channels
  channel "feed:*", Example2Web.FeedChannel
  channel "feed", Example2Web.FeedChannel

  def connect(params = %{"user_id" => user_id}, socket, _connect_info) do
    socket = assign(socket, :user_id, user_id)
    {:ok, socket}
  end

  def id(%{assigns: %{user_id: user_id}}), do: "user:#{user_id}"
end
