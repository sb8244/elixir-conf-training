defmodule Example2.RateLimit.Server do
  use GenServer

  def start_link(opts) do
    name = Keyword.get(opts, :name, __MODULE__)
    GenServer.start_link(__MODULE__, [], name: name)
  end

  # cas = check and set
  def cas_rate_limit(pid \\ __MODULE__) do
    GenServer.call(pid, :cas_rate_limit)
  end

  # Callbacks

  def init(_) do
    {:ok, %{rate_limited?: false}}
  end

  def handle_call(:cas_rate_limit, _from, state = %{rate_limited?: true}) do
    {:reply, {:ok, :rate_limited}, state}
  end

  def handle_call(:cas_rate_limit, _from, state) do
    Process.send_after(self(), :clear_rate_limit, 5_000)
    {:reply, {:ok, :open}, %{state | rate_limited?: true}}
  end

  def handle_info(:clear_rate_limit, state) do
    {:noreply, %{state | rate_limited?: false}}
  end
end
