defmodule Example2Web.FeedChannel do
  use Phoenix.Channel

  def join("feed:" <> _x, _params, socket) do
    {:ok, socket}
  end
end
