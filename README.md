# Section 2 Example

## Getting Setup

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm --prefix assets install`
  * Start Phoenix endpoint with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Section 3 - Part 2

In this section, you're going to network nodes together, pass messages back and forth,
and observe the box using `observer_cli`.

### 1. Network your nodes together

You can easily create a local network of nodes with libcluster. We will start a web server with the
name `app@127.0.0.1` and an application server (no web) with the name `backend@127.0.0.1`.

Configure `application.ex` with the correct names. Then try to start the nodes:

```
$ iex --name app@127.0.0.1 -S mix
iex(app@127.0.0.1)1> Node.list
[:"backend@127.0.0.1"]

$ iex --name backend@127.0.0.1 -S mix
iex(backend@127.0.0.1)1> Node.list
[:"app@127.0.0.1"]
```

You can see that the nodes are connected together. Here are some questions to consider:

* What happens if a Node becomes disconnected and then reconnects?
* What would happen if you had 3 servers, 4?

### 2. Dispatch an event across the cluster

You can use the existing `Mock.ActivityCreator` to create an activity from the backend node. This will trigger
a PubSub event. What do you expect to happen when you do this?

```
$ iex --name backend@127.0.0.1 -S mix
iex(backend@127.0.0.1)1> Node.list
[:"app@127.0.0.1"]
iex(backend@127.0.0.1)2> Example2.Mock.ActivityCreator.create_random_activity()
```

Does the UI at http://localhost:4000 update when you run this? Why is that?

### 3. Leverage observer_cli

We have already included the `observer_cli` in the `mix.exs` file for you. You can now start a session from
the iex terminal.

```
$ iex -S mix phx.server
iex(1)> :observer_cli.start
q+enter when you're ready to quit
```

Inspect the main sections of the home screen. At the top there is the different aspects of your
general system health. Next is % usage of each scheduler that you have. Finally, there is a list
of processes (you may need to make your shell taller if you're missing these sections).

Open up many tabs of `http://localhost:4000`. Can you find the Channel.Server process in the observer_cli
interface? Enter the number of one of the processes and press enter. You will be taken to the process info
screen. Investigate different properties, such as State(s), in order to see how the Channel process is
configured.

`observer_cli` can be very useful in a time of need in production. Learning how to use it can save a lot of
frustration down the road. I've used it to debug high memory usage and high reduction usage in a cluster of
servers.

### (hard) Network your nodes via DNS

Configure your node networking via DNS rather than epmd. You may need to setup host entries
locally to create the right DNS entry. If you can't get that setup, just try to configure
it regardless to see how the DNS strategy would be configured.

Hint, it's marked as kubernetes-dns despite working with all DNS servers.

### (hard) Configure a pg2 group locally

Knowing how to use pg2 manually is very useful. Try to configure a pg2 based process group which
allows for identifying an instance of a process on a different node.

When might this be useful?
