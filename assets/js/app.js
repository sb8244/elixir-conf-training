import css from "../css/app.css"
import LiveSocket from "phoenix_live_view"

// LiveView will automatically all relevant views
let liveSocket = new LiveSocket("/live")
liveSocket.connect()
window.liveSocket = liveSocket

// window.createFakeActivity = () => {
//   const data = generateFakeActivityData()
//   createActivity(feed, data).then(console.log).catch(console.error)
// }
