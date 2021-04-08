import { Socket } from "phoenix" 
import { get_token, get_username } from '../api';
import store from '../store'

let token = get_token();
let socket = new Socket("ws://localhost:4000/socket", {params: {token: token, username: get_username()}})
let channel;
let state = [];
let callback;

export function local_state_update(st) {
    state = st;
}

export function state_update() {
    if(callback) {
        callback(state);
    }
}

export function set_callback(cb) {
    callback = cb;
}

function store_lives(st) {
    store.dispatch({
        type: "lives/set",
        data: st
    });
}

export function ch_join() {
    if(token) {
        socket.connect();
        channel = socket.channel("main", {})
        channel.join()
        .receive("ok", resp => {
            local_state_update(resp)
            store_lives(resp)
            channel.on("view", payload => {
                store_lives(payload.data);                
                local_state_update(payload.data);
            })
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