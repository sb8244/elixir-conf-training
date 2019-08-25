import socket from "./socket"

export function getFeed() {
  const feedChannel = socket.channel("feed:me")

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
    channel.push("fetch", { page: 1, per_page: 50 })
      .receive("ok", resolve)
      .receive("error", reject)
      .receive("timeout", reject)
  })
}
