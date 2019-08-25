# Section 2 Example

## Getting Setup

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm --prefix assets install`
  * Start Phoenix endpoint with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Section 2 - Part 1

This application is an event log of your application. It shows different events that are happening in
the system. This is very similar to an activity feed or notification system that are present in most
applications today.

For part 1 of this section, you're going to be filling in the missing code to add basic Phoenix Channel
support to the application. Most of the application is already written—you'll just need to fill in some
of the gaps.

### 1. Incorrect Socket Path

If you load the webpage and look at the JavaScript console, you will see that there is a 404 error because
`/incorrect_socket/websocket` does not exist. Follow the comment in `socket.js` and correct the error. When
you fix it, you will see the JavaScript error disappear. Your Phoenix Logs will indicate a successful Socket
and Channel connection.

### 2. `handle_in/3` is not responding correctly

Once you fix 1, you will start getting a crash because of `handle_in/3` being broken. This lives in the
`FeedChannel` module. The docs for Channels have an example of the correct format that you should send
a reply in. Make this change and the frontend will start displaying 3 sample items.

https://hexdocs.pm/phoenix/Phoenix.Channel.html

### 3. Data not pushing down

If you create a new Activity by running this command in your `iex -S mix phx.server` session, you will see
that the frontend doesn't update:

```elixir
Example2.Mock.ActivityCreator.create_random_activity()
```

The `Activity` context has a create function which should send this data to connected clients after creation.
However, it's not doing that now. Add in the right function with the correct topic and event name. You'll need
to look around at both the server and client code to collect all of this information.

### 4. Try out faster updates to the frontend

Nothing to fix here, just a good spot for a demo! Try creating many Activities on the server with a helper command
we have prepared for you. Watch the frontend as you do this. This command must be entered into
your `iex -S mix phx.server` session.

```elixir
Example2.Mock.ActivityCreator.create_many_activities()
```

You should see the frontend live updating if you fixed all of the previous bugs.

### 5. Create Activity via the Frontend

Finally, let's send data from the frontend to the server. The client is already pushing up the activity data
when you run this function in the JavaScript console:

```javascript
createFakeActivity()
```

This will generate fake Activity data (like the server does) and pass it to the Channel. You will see it fail
because `handle_in/3` is not implemented for the message. Implement the function according to the comment
located in the `FeedChannel` module.

When it works, you should be able to run `createFakeActivity()` and it will both create and push the activity
down to your page.

## Section 2 - Part 2

In this section, you're going to see that Channels are just processes. You'll be extending the `FeedChannel`
to have a rate limit of 1 request per second.

### 1. Activate rate limiting

There is a function in `FeedChannel` called `rate_limit_socket/1`. It's going to modify the `socket` state in
order to enable rate limiting. However, the function currently just returns the socket and rate limiting is
not applied. Set the state of the Channel to include `rate_limited? = true`

If you get stuck, investigate the Socket docs to learn the function to apply state to the `socket` struct.
https://hexdocs.pm/phoenix/Phoenix.Socket.html

You can test that this works by running `createFakeActivity()` twice from the JavaScript console. You should see an
error that says "rate limit exceeded" if rate limiting is applied. If you wait 5s, you'll see that it is
still applied.

### 2. Stop rate limiting

From the above test, you can see that rate limiting doesn't become unapplied. This makes sense because nothing
in our code is clearing the state.

Like you would with a normal `GenServer`, send your `self()` a message after 5s that deactivates
rate limiting, by setting `rate_limited? = false`.

You can test that this works by running `createFakeActivity()` twice from the JavaScript console. You should see an
error that says "rate limit exceeded" if rate limiting is applied. If you wait 5s, you'll see that the request works
again.

### 3. Observe multiple open tabs

No code changes for this section, but it's good to understand how `socket` state works.

Open 2 tabs of http://localhost:4000. Run `createFakeActivity()` in 1 of the tabs, and then immediately run
it from the other tab.

* What happens?
* Are you surprised at all by the result? Why did it happen this way?
* What would you need to do to change this behavior (to do the opposite of what it actually does)?

(spoilers below)

### 4. (hard mode) Make the rate limiting apply across page reloads

(spoilers for 3 below)

Based on the results of the last observation, let's actually change the behavior to work across multiple
tabs or page reloads. This is a more advanced task because you will need to add new modules and behavior to the
system, rather than filling in a function or 2.

The goal of this task is to issue a frontend creation, refresh, and then issue another one. The second creation
should be rate limited still, until 5s passes.

Try building the rate limiter for a single user first (like we have now), but then build in the idea of having
multiple connected users with their own rate limits.
