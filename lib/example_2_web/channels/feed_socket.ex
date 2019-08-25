defmodule Example2Web.FeedSocket do
  use Phoenix.Socket

  ## Channels
  channel "feed", Example2Web.FeedChannel

  def connect(_params, socket, _connect_info) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end
