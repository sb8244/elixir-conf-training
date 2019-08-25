import css from "../css/app.css"
import { getFeed, startFeed, fetchFeed, onNewActivity, generateFakeActivityData, createActivity } from './feed'
import { addActivityToTop } from "./dom"

const feed = getFeed()

startFeed(feed).then(() => {
  fetchFeed(feed).then(({ activities }) => {
    activities.reverse().forEach(addActivityToTop)
  }).catch((err) => {
    console.error('fetchFeed error', err)
  })
}).catch((err) => {
  console.error('startFeed error', err)
})

onNewActivity(feed, addActivityToTop)

window.createFakeActivity = () => {
  const data = generateFakeActivityData()
  createActivity(feed, data).then(console.log).catch(console.error)
}
