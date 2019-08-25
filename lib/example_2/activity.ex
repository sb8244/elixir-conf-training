defmodule Example2.Activity do
  alias __MODULE__.{ActivityStore}

  defdelegate all(params), to: ActivityStore

  def create(params) do
    case ActivityStore.create(params) do
      ret = {:ok, activity} ->
        broadcast_activity(activity)
        ret

      ret = _ ->
        ret
    end
  end

  defp broadcast_activity(activity) do
    # TODO: You should add 1 line of code here to send the activity to the correct topic and
    # message type. Look at `feed.js` to see what the topic is, and also what the message
    # name is. You will want to broadcast the message data
    Example2Web.Endpoint.broadcast("feed", "activity.created", activity)
  end
end
