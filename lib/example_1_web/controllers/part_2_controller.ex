defmodule Example1Web.Part2Controller do
  use Example1Web, :controller
  alias Example1.Part2.Producer

  def genstage(conn, _params) do
    :ok =
      Producer.enqueue_event(%{
        event_occurred_at: System.monotonic_time()
      })

    text(conn, "OK")
  end
end
