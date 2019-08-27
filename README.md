# Section 2 Example

## Getting Setup

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm --prefix assets install`
  * Start Phoenix endpoint with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Section 3 - Part 1

In this section you will be exploring metrics collection via telemetry.

### 1. A Simple Event

(Telemetry Documentation)[https://github.com/beam-telemetry/telemetry]

Open the console and produce an event using the following command

```
Example2.Metrics.ExampleMetricsProducer.emit_simple()
```

Checkout `Example2.Metrics.ExampleMetricsHandler` to see how that event is being handled

Try to do the following based on the telemetry documentation
  * Add a new data key-val pair of the event `my_data: :foo`
  * Add a new metadata entry to the event `my_metadata: :bar`
  * Add the new config value `my_config: :baz` to the configuration of the `[:example, :simple]` handler

### 2. Aggregating Metrics

Familiarize yourself with the event being emitted by `Example2.Metrics.ExampleMetricsProducer.example_event()`

Try to add the following stats to the statsd collector being started in `application.ex`. Checkout the docs for `Telemetry.Metrics`
for how to do so:

  * The number of occurrences of the `[:example, :foo]` event
  * The sum of the values of `data_val_1`
  * The sum of the values of `data_val_2` partitioned by the value of `:metadata_key`

### 3. (Hard Mode) Create a metric that polls your BEAM node for memory stats

Keeping track of BEAM stats is very important for production deployments. Create a special type of telemetry dispatcher
that chirps memory stats every second or so.

### 4. (Hard Mode) Put Metrics on all the Phoenix telemetry events

Find the telemetry events that Phoenix allows (you can do this without using the internet!), and then add metrics for
each.
