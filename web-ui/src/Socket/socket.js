import { Socket } from "phoenix" 
import { get_token, get_username } from '../api';

let token = get_token();
let socket = new Socket("ws://localhost:4000/socket", {params: {token: token, username: get_username()}})

export function ch_join() {
    if(token) {
        socket.connect();
        let channel = socket.channel("room:" + get_username(), {})
    
        channel.join()
        .receive("ok", resp => {
            console.log("joined");
        })
        .receive("error", resp => {
            console.log("error");
        }) 
    }
}

export function socket_disconnect() {
    socket.disconnect();
}