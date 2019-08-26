defmodule Example2Web.PageController do
  use Example2Web, :controller

  def index(conn, _params) do
    render(conn, "index.html", user_id: random_user_id())
  end

  defp random_user_id do
    :rand.uniform(1_000_000)
  end
end
