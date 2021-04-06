import React from 'react';
import { useSelector } from "react-redux";
import Login from '../Login/login'

export default function Home() {
    const session = useSelector(state => state.session)
    // TODO
    if (session) {
        return (
            <h2>Can you smell what the rock is cooking?</h2>
        );
    }
    else {
        return <Login />
    }
}