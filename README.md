# Section 2 Example

## Getting Setup

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm --prefix assets install`
  * Start Phoenix endpoint with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

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
