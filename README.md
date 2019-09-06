# Building Scalable Real-time Systems in Elixir - Section 1 Example

# Getting Setup
  * Install dependencies with `mix deps.get`
  * Install Node.js dependencies with `npm --prefix assets install`
  * Start Phoenix endpoint with `iex -S mix phx.server`
  * Now you can visit localhost:4000 from your browser.

## Section 1 Part 2

In this section we will be exploring building a data pipeline using GenStage

### 1.) Find the Genstage Components

Follow the supervision tree from your main [application supervisor](/lib/example_1/application.ex) `application.ex`, and
locate the GenStage components running in your process tree. Once you've found the code for the component, locate the
processes running in the `:observer`

### 2.) Examine the GenStage

Starting with the part2 [controller](/lib/example_1_web/controllers/part_2_controller.ex), trace your way through the gen stage pipeline.
  * What is the controller doing?
  * What is the producer doing?
  * What is the consumer doing?

Take a look at the code for the control panel for part 2 `/lib/example_1_web/controllers/live/part_2_live.ex`
  * What is it doing?
  * What metrics is it collecting?

### 3.) Enqueue some events

Navigate to the `localhost:4000/part2`.

Predict the answers to the following questions, then verify your assumptions using the apache bench tool with 1000 requests to the `/part2/genstage` endpoint
  * How will the number of unprocessed events in the system change over time?
  * How will the `MockResource` usage change with the number of events?

```
ab -k -n 1000 -c 50 http://127.0.0.1:4000/part2/genstage
```

### 4.) Increase the number of consumers to 3

How will adding 2 more consumers to the system change the following values?
  * How will the speed of processing events change?
  * How will the `MockResource` usage change?

Add 2 more consumers to the system and then Verify your assumptions using `ab` and the dashboard at `localhost:4000/part2`

### 5.) Measure the latency of events flowing through your pipeline

The LiveView currently measures the latency of events through the system.

Answer the following questions:

  * How does the latency each event experience change as the depth of the queue changes?
  * How does adding multiple consumers affect the average latency? (Its trickier than you'd think)

### 6.) (Hard Mode) Consumer Supervisor

Read the [docs](https://hexdocs.pm/gen_stage/ConsumerSupervisor.html) for consumer supervisor

Implement the GenStage consumers as a consumer supervisor with a concurrency that can be controlled via the `config/config.exs`
