defmodule Counter do
  use Agent

  def start_link(name: name), do: Agent.start_link(fn -> 0 end, name: name)

  def value(counter), do: Agent.get(counter, & &1)

  def increment(counter), do: Agent.update(counter, &(&1 + 1))

  def decrement(counter), do: Agent.update(counter, &(&1 - 1))
end
