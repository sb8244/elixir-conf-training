defmodule Example1Web.ChannelCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with channels
      use Phoenix.ChannelTest

      # The default endpoint for testing
      @endpoint Example1Web.Endpoint
    end
  end

  setup _tags do
    :ok
  end
end
