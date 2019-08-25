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

### 6. (hard mode) Asynchronously create the Activity, so that the socket remains available

When the Socket is creating an activity, it is unavailable to process other requests. Utilize a `socket_ref` in
order to asynchronously process the Activity. You can do this all in the same file as the Channel, you don't need
to make a new GenServer (ask for hints if you're not sure how you'd go about this).

From the frontend, run `createFakeActivity() ; createFakeActivity()` in order to trigger 2 creations back to
back. You should see them pop in at the same time after 1 second. If they come in over 2 seconds (1 second apart),
then you know that the message wasn't handled asynchronously.
