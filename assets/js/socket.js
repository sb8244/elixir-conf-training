import {Socket} from "phoenix"

let socket = new Socket("/feed_socket", { params: { token: window.userToken }})

socket.connect()

export default socket
