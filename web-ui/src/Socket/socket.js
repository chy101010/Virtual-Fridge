import { Socket } from "phoenix" 
import { get_token, get_username } from '../api';

let token = get_token();
let socket = new Socket("ws://localhost:4000/socket", {params: {token: token, username: get_username()}})
let channel;
let state = [];
let callback;

export function state_update(st) {
    state = st;
    if(callback) {
        console.log("ssate_update");
        callback(st);
    }
}

export function set_callback(cb) {
    callback = cb;
    console.log("set_callback");
    callback(state);
}

export function ch_join() {
    if(token) {
        socket.connect();
        channel = socket.channel("main", {})
        channel.join()
        .receive("ok", resp => {
            channel.on("view", payload => {
                console.log(payload, "above");
                state_update(payload.data);
                console.log(payload, "below");
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

// export function ch_get_test() {
//     channel.push("get", "")
//     .receive("ok", resp => {
//         console.log(resp)
//     })
//     .receive("error", resp => {
//         console.log(resp);
//     })
// }