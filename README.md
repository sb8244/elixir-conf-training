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
