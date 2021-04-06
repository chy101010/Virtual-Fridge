import { Socket } from "phoenix" 

let socket = new Socket("ws://localhost:4000/socket", {params: {token: ""}})

socket.connect();

export function ch_join_room(user) {
    let channel = socket.channel("room:" + 1, {});
    channel.join().receive("ok", response => {
        console.log("joinned");
    }).receive("error", resp => {
        console.log("error")
    })
}