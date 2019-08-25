defmodule Example2.Activity do
  alias __MODULE__.{ActivityStore}

  defdelegate all(params), to: ActivityStore

  def create(params) do
    case ActivityStore.create(params) do
      ret = {:ok, activity} ->
        Example2Web.Endpoint.broadcast("feed", "activity.created", activity)
        ret

      ret = _ ->
        ret
    end
  end
end
