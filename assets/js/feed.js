import socket from "./socket"

export function getFeed() {
  const feedChannel = socket.channel("feed")

  return {
    channel: feedChannel
  }
}

export function startFeed({ channel }) {
  return new Promise((resolve, reject) => {
    channel.join()
      .receive("ok", resp => { resolve() })
      .receive("error", resp => { reject(resp) })
      .receive("timeout", resp => { reject(resp) })
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

export function onNewActivity({ channel }, callback) {
  channel.on('activity.created', (activity) => {
    callback(activity)
  })
}
