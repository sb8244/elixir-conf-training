import css from "../css/app.css"
import socket from "./socket"

const feedChannel = socket.channel("feed:me")

feedChannel.join()
  .receive("ok", resp => { console.log("Joined feed", resp) })
  .receive("error", resp => { console.log("Unable to join feed", resp) })
