defmodule Example2Web.FeedLive do
  use Phoenix.LiveView

  alias Example2.Activity

  def render(assigns) do
    ~L"""
    <button phx-click="create_random">Create Random Activity</button>

    <div>
      <%= for activity <- @activities do %>
        <div class="activity-wrapper">
          <span class="activity-wrapper__main"><%= activity.what %></span>
          <span class="activity-wrapper__time"><%= DateTime.to_string(activity.occurred_at) %></span>
          <span class="activity-wrapper__tier activity-wrapper__tier--<%= activity.customer_tier %>">
            <%= activity.customer_tier %>
          </span>
        </div>
      <% end %>
    </div>
    """
  end

  def mount(%{user_id: user_id}, socket) do
    # We only want to connect the "feed" topic when the LiveView Socket is connected
    if connected?(socket) do
      :ok = Phoenix.PubSub.subscribe(Example2.PubSub, "feed")
    end

    # TODO (1) This LiveView is loading without any existing Activities.
    socket =
      socket
      |> assign(:user_id, user_id)
      |> assign(:activities, initial_activities(connected?(socket)))
    {:ok, socket}
  end

  # We can handle events that come in from the UI, like this button click
  def handle_event("create_random", _event, socket) do
    Example2.Mock.ActivityCreator.create_random_activity()
    {:noreply, socket}
  end

  # We receive new activity.created events and handle them in the LiveView
  def handle_info(%Phoenix.Socket.Broadcast{event: "activity.created", payload: activity}, socket) do
    socket = update(socket, :activities, & [activity | &1])
    {:noreply, socket}
  end

  # TODO (2) Make it so that the initial page load only loads 3, but the Socket connection loads 25
  defp initial_activities(false) do
    Activity.all(%{"limit" => 3})
  end

  defp initial_activities(true) do
    Process.sleep(1000) # This is just to illustrate the difference in mount vs real-time
    Activity.all(%{"limit" => 25})
  end
end
