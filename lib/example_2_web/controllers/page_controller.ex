defmodule Example2Web.PageController do
  use Example2Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
