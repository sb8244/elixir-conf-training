# Section 2 Example

## Getting Setup

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm --prefix assets install`
  * Start Phoenix endpoint with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Section 4 - Part 1

You will be leveraging `Phoenix.Tracker` in this section. The usage of `Phoenix.Presence` is
very similar to `Tracker`, so we'll be focusing on `Tracker`. It gives us easier access to
inspect `handle_diff`, which you'll do below.

### 1. Use the Tracker when a Channel is joined

The Tracker is configured for you, but isn't being used. Make it so that the Channel uses `track`
after a Channel is joined. Note that there are 2 different feeds. The first is a generic `feed`
that all users see. The other is `feed:userId` which could be for a given user only.

### 2. Track the user's name

It would be really helpful to have the User's name when they join a feed. This information is
passed into the Channel, but we don't have it stored in the Tracker. Make it so that the Tracker
has the name. It should look something like this:

```
iex(1)> Phoenix.Tracker.list(Example2Web.FeedTracker, "feed")
[
  {"user:122963",
   %{name: "Steve", online_at: 1566788438810, phx_ref: "6y6iRQk2Ges="}},
  {"user:535839",
   %{name: "Katie", online_at: 1566788438831, phx_ref: "O0Ftqm9Y9dM="}},
  {"user:973528",
   %{name: "Erica", online_at: 1566788438842, phx_ref: "D5FK5Wcpers="}}
]
```

### 3. Inspect the available data in `handle_diff`

How does `handle_diff` return data currently?

It's logged for your convenience, and you should see the logs when you join/leave a Channel. You can
trigger a Channel leave by closing or refreshing the page.

### 4. Create a local cluster to see distribution behavior

It's easy to get started with distributed Elixir. Locally, you can get running in a few steps:

```
$ iex --name app@127.0.0.1 -S mix phx.server
```

```
$ iex --name back@127.0.0.1 -S mix
iex(back@127.0.0.1)1> Node.connect(:"app@127.0.0.1")
true
```

Try to run commands from the "back" node to see what happens. Keep in mind that no WebSocket connection
is attached to the "back" node, because it isn't exposing a phoenix server.

```
$ Phoenix.Tracker.list(Example2Web.FeedTracker, "feed")
# What do you see?
```

Also keep an eye on how `handle_diff` is invoked on the backend node. What implications would this have
if you were operating on handle_diff?

### (hard mode) Switch out `Phoenix.Tracker` for `Phoenix.Presence`

We now want to have the list of joined feeds on the frontend. Swap out Tracker for Presence and let diff events go to the
client. Verify that the diffs are being received by looking at the network tab and investigating the WebSocket data.

Use the Presence class in the JavaScript client to keep track of the presence on the frontend.
