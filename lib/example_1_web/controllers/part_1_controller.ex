defmodule Example1Web.Part1Controller do
  use Example1Web, :controller
  alias Example1.MockResource

  def serial(conn, _params) do
    :ok = MockResource.use_resource()
    text(conn, "OK")
  end

  def async(conn, _params) do
    spawn(fn -> :ok = MockResource.use_resource() end)
    text(conn, "OK")
  end
end
