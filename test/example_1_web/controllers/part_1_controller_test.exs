defmodule Example1Web.Part1ControllerTest do
  use Example1Web.ConnCase
  alias Example1.MockResource

  test "GET /part1/async", %{conn: conn} do
    conn = get(conn, "/part1/async")
    assert text_response(conn, 200) =~ "OK"
  end

  test "GET /part1/serial", %{conn: conn} do
    conn = get(conn, "/part1/serial")
    assert text_response(conn, 200) =~ "OK"
  end

  test "it increments the counter for part1 while its going", %{conn: conn} do
    assert 0 == MockResource.current_requests()
    spawn_link(fn -> get(conn, "/part1/serial") end)
    Process.sleep(100)
    assert 1 == MockResource.current_requests()
    Process.sleep(500)
    assert 0 == MockResource.current_requests()
  end
end
