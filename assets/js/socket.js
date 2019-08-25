import {Socket} from "phoenix"

// TODO: Investigate Endpoint.ex to discover what the correct Socket path is.
let socket = new Socket("/incorrect_socket")

socket.connect()

export default socket
