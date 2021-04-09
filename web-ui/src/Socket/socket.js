import { Socket } from "phoenix" 
import { get_token, get_username } from '../api';
import store from '../store'

let token = get_token();
let socket = new Socket("wss://cooking-app-server.wumbo.casa/socket", {params: {token: token, username: get_username()}})
let channel;
let state = [];
let callback;
let state_nav = [];
let callback_nav;

export function local_state_update(st) {
    state = st;
}

export function local_state_nav_update(st) {
    state_nav = st;
}

export function state_update() {
    if(callback) {
        callback(state);
    }
}

export function set_callback(cb) {
    callback = cb;
}

export function state_update_nav() {
    if(callback_nav) {
        callback_nav(state_nav);
    }
}

export function set_callback_nav(cb) {
    callback_nav = cb;
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
	        local_state_nav_update(resp)
            store_lives(resp)
            channel.on("view", payload => {
                store_lives(payload.data);                
                local_state_update(payload.data);
	            local_state_nav_update(payload.data);
            })
        })
        .receive("error", resp => {
        }) 
    }
}

export function socket_disconnect() {
    channel.leave();
    socket.disconnect();
}
