# Section 2 Example

## Getting Setup

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm --prefix assets install`
  * Start Phoenix endpoint with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Section 4 - Part 2

In this part, you will be working with a LiveView version of section 2 from this course. The
feed view has been written to have minimal JavaScript and instead leverage Phoenix LiveView to
fully power the UI.

### 1. No initial activities

The LiveView is loading without error, but it's empty. Go ahead and figure out a way to load
3 activities into the initial UI.

### 2. Explore the difference between server rendering and Socket rendering

In order to keep our first paint very quick, the UI is rendering only 3 initial activities. Find a way
to make it so the initial load does 3 activities, but the socket then loads 25. To make this really
apparent, add `Process.sleep(1000)` when the socket activities load.

The UI should show 3 activities for 1 second before filling in with 25.

### 3. Investigate LiveView WebSocket data

What is the magic of LiveView? Let's investigate several different parts of the frontend to see it in
action.

The first thing you should inspect is the page source (view-source:http://localhost:4000/). What do
you notice about how the page is loaded? What are the implications of this?

The next thing to inspect is the WebSocket messages. In Chrome DevTools, you can do this by opening the
network tab and going to the "WS" subtab. You will see an entry for `/live/websocket`. Click on this
and watch what happens as the UI changes. You can press the create button to trigger a change.

What are the implications of LiveViews communication model?

### 4. (hard mode) Make the LiveView data load be asynchronous

If you finish part 2, you will have a view that takes 1 second to load. During that time no one message
can be processed. If you click the "Create random activity" button, it will just wait until the 1s is up.

Change the flow so that nothing happens that would ever block the process. Keep the `Process.sleep/1` call
in order to force a slow operation.
