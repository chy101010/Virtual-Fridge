import { Socket } from "phoenix" 
import { get_token, get_username } from '../api';

let token = get_token();
let socket = new Socket("ws://localhost:4000/socket", {params: {token: token, username: get_username()}})
let channel;

export function ch_join() {
    if(token) {
        socket.connect();
        channel = socket.channel("main", {})
        channel.join()
        .receive("ok", resp => {
            channel.on("view", payload => {
                console.log(payload);
            })
            console.log("joined");
        })
        .receive("error", resp => {
            console.log("error");
        }) 
    }
}

export function socket_disconnect() {
    channel.leave();
    socket.disconnect();
}

export function ch_get_test() {
    channel.push("get", "")
    .receive("ok", resp => {
        console.log(resp)
    })
    .receive("error", resp => {
        console.log(resp);
    })
}