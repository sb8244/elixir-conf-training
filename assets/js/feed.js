import {Socket} from "phoenix"

export function getFeed() {
  const name = randomName()
  const fakeId = Math.floor(Math.random()*1000000)
  const socket = new Socket("/feed_socket", { params: { user_id: fakeId } })
  const feedChannel = socket.channel(`feed:${fakeId}`, { name })
  const allChannel = socket.channel(`feed`, { name })

  socket.connect()

  console.log('Joining channels:', `feed and feed:${fakeId}`)

  return {
    channel: feedChannel,
    allChannel,
    socket
  }
}

export function startFeed({ channel, allChannel }) {
  return new Promise((resolve, reject) => {
    channel.join()
      .receive("ok", resp => { resolve() })
      .receive("error", resp => { reject(resp) })
      .receive("timeout", resp => { reject(resp) })

    allChannel.join()
  })
}

export function fetchFeed({ channel }) {
  return new Promise((resolve, reject) => {
    channel.push("fetch", { limit: 10 })
      .receive("ok", resolve)
      .receive("error", reject)
      .receive("timeout", reject)
  })
}

export function createActivity({ channel }, data) {
  return new Promise((resolve, reject) => {
    channel.push("create_activity", data)
      .receive("ok", resolve)
      .receive("error", reject)
      .receive("timeout", reject)
  })
}

export function onNewActivity({ channel }, callback) {
  channel.on('activity.created', (activity) => {
    callback(activity)
  })
}

export function generateFakeActivityData() {
  const verb = randomVerb()
  return {
    customer_tier: randomValue(["A", "B", "C", "D"]),
    what: [randomName(), verb, randomNoun()].join(" "),
    what_type: verb,
    who_id: Math.floor(Math.random() * 10000000)
  }
}

function randomValue(arr) {
  return arr[Math.floor(Math.random()*arr.length)]
}

function randomName() {
  return randomValue(["Sarah", "Steve", "Ben", "Katie", "Erica", "Grant", "Jacob"])
}

function randomVerb() {
  return randomValue(["edited", "viewed", "deleted"])
}

function randomNoun() {
  return randomValue(["an email", "a person", "a company"])
}
