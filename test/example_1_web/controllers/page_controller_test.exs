defmodule Example1Web.PageControllerTest do
  use Example1Web.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Elixir Conf Example"
  end
end
