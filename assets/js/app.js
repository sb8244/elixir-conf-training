import css from "../css/app.css"
import { getFeed, startFeed, fetchFeed } from './feed'

const feed = getFeed()

startFeed(feed).then(() => {
  fetchFeed(feed).then((activities) => {
    console.log(activities)
  }).catch((err) => {
    console.error('fetchFeed error', err)
  })
}).catch((err) => {
  console.error('startFeed error', err)
})
