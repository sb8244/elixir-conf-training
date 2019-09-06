defmodule Example1.Application do
  use Application
  alias Example1.MockResource

  def start(_type, _args) do
    unless Mix.env() == :test do
      :observer.start()
    end

    children = [
      Example1Web.Endpoint,
      Example1.Part2.Supervisor,
      MockResource,
      {Counter, name: EventsInSystem}
    ]

    opts = [strategy: :one_for_one, name: Example1.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    Example1Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
