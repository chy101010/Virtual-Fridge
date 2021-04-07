import React, { useState, useEffect } from 'react';
import { useSelector } from "react-redux";
import Login from '../Login/login'

import { set_callback, state_update } from '../Socket/socket'

export default function Home() {
    const session = useSelector(state => state.session)
    const [state, setState] = useState([])

    useEffect(() => {
        console.log("called Effect")
        state_update(state);
        set_callback(setState);
    })
    
    console.log(state, "home")

    if (session) {
        return (
            <h2>Can you smell what the rock is cooking?</h2>
        );
    }
    else {
        return <Login />
    }
}