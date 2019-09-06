defmodule Example1.MockResourceTest do
  use ExUnit.Case
  alias Example1.MockResource

  setup do
    name = :"#{:erlang.unique_integer()}"
    {:ok, pid} = MockResource.start_link(name: name)
    {:ok, pid: pid, name: name}
  end

  test "it can be started", %{pid: pid} do
    assert Process.alive?(pid)
  end

  test "it starts with a value of 0", %{name: name} do
    assert 0 == MockResource.current_requests(name)
  end

  test "using the resource from another process will cause count to go up", %{name: name} do
    assert 0 == MockResource.current_requests(name)
    Task.async(fn -> MockResource.use_resource(name) end)
    Process.sleep(50)
    assert 1 == MockResource.current_requests(name)
    Process.sleep(500)
    assert 0 == MockResource.current_requests(name)
  end
end
