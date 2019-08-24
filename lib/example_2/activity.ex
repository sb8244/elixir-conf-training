defmodule Example2.Activity do
  alias __MODULE__.{ActivityStore}

  defdelegate create(params), to: ActivityStore
end
