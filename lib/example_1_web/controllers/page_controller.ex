defmodule Example1Web.PageController do
  use Example1Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
