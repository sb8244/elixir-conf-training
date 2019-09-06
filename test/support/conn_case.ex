defmodule Example1Web.ConnCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest
      alias Example1Web.Router.Helpers, as: Routes

      # The default endpoint for testing
      @endpoint Example1Web.Endpoint
    end
  end

  setup _tags do
    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
