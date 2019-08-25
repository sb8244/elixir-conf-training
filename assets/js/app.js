import css from "../css/app.css"
import { getFeed, startFeed, fetchFeed, onNewActivity } from './feed'
import { addActivityToTop } from "./dom"

const feed = getFeed()

startFeed(feed).then(() => {
  fetchFeed(feed).then(({ activities }) => {
    activities.forEach(addActivityToTop)
  }).catch((err) => {
    console.error('fetchFeed error', err)
  })
}).catch((err) => {
  console.error('startFeed error', err)
})

onNewActivity(feed, addActivityToTop)
