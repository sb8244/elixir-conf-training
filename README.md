# Building Scalable Real-time Systems in Elixir - Section 1 Example

# Getting Setup
  * Install dependencies with `mix deps.get`
  * Install Node.js dependencies with `npm --prefix assets install`
  * Start Phoenix endpoint with `iex -S mix phx.server`
  * Now you can visit localhost:4000 from your browser.

## Section 1 Part 1

We want you to see the effects of serialism and parallelism in Elixir. We have coded a small app that will process
some work and respond to a request. In one case, the work will be done serially, in the same process as the request.
In another case, the work will be done asynchronously and the request will not wait for the work to be performed.

## 1. Understanding IO wait, What is `MockResource` Doing in Each Endpoint

Open the `MockResource` module found in `lib/example1/mock_resource`
  * What is the `use_resource` function doing?
  * What is the `current_requests` function doing?
  * Where is an instance of `MockResource` being started in the supervision tree? Can you find it using the `:observer`
  * What are some examples of compute resources that `MockResource` models well? What are some compute resources that `MockResource` does not model well?

How is the `MockResource` being used in the `/part1/serial` endpoint? How is it being used in the `/part1/async` endpoint?

Find the LiveView [code](/lib/example_1_web/controllers/live/part_1_live.ex) for the `/part1` page
  * What is it measuring?

## 2. Using `ab` (A.K.A ApacheBench)

Apache Bench is a tool from the Apache foundation to load test HTTP servers. [docs](https://httpd.apache.org/docs/2.4/programs/ab.html)

After you've understood the runtime characteristics of the `part1/sync` and `part2/async` endpoints, guess at the results of the following benchmarks and then test your assumptions
  * 3000 requests using a concurrency of 50 against `part1/serial`
  * 3000 requests using a concurrency of 50 against `part1/async`

How long did each request take? Which endpoint returned to the client the fastest? What is the implication on memory and cpu usage, can you see these in the `:observer` screens?

```
ab -k -n 3000 -c 50 http://127.0.0.1:4000/part1/serial
```

```
ab -k -n 3000 -c 50 http://127.0.0.1:4000/part1/async
```

## 3.) Looking at concurrent requests to `MockResource` during your benchmarks

The number of concurrent requests can be found at `http://localhost:4000/part1`

Make a hypothesis about the number of concurrent requests to mock resources for each of the following benchmarks, then test your hypothesis
  * 3000 requests using a concurrency of 50 against `part1/serial`
  * 3000 requests using a concurrency of 50 against `part1/async`

What are the implications of the data you collected in these tests?
  * From the web client's perspective, which endpoint is faster?
  * What would happen is MockResource was your database? What if `MockResource` was a resource that could only handle limited load?

## 4.) (Hard Mode) How slow can you go

Make the requests to the endpoints fail and return a 500 if there are already 15 concurrent requests to the `MockResource`
