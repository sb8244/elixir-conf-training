defmodule Example1.MockResource do
  use Agent

  def use_resource(resource \\ __MODULE__) do
    Agent.update(resource, &(&1 + 1))
    Process.sleep(500)
    Agent.update(resource, &(&1 - 1))
  end

  def current_requests(resource \\ __MODULE__), do: Agent.get(resource, & &1)

  def start_link([]), do: start_link(name: __MODULE__)
  def start_link(name: name), do: Agent.start_link(fn -> 0 end, name: name)
end
