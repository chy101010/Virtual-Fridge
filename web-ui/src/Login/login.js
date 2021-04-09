import React from 'react';
import { useState } from 'react';
import { Form, Button} from 'react-bootstrap';
import { useHistory } from 'react-router';
import { Link } from 'react-router-dom';
import { api_login } from '../api';
import store from "../store";
import { ch_join } from "../Socket/socket"

export default function Login() {
    let history = useHistory();
    const [user, setUser] = useState({ username: "", password: "" })

    async function onSubmit(ev) {
        ev.preventDefault();
        let result = await api_login(user.username, user.password);
        if (result.session) {
            store.dispatch({ type: 'session/set', data: result.session });
            store.dispatch({ type: "success/set", data: `Welcome back ${result.session.username}!` });
            ch_join();
            history.push('/');
        }
        else {
            store.dispatch({ type: 'error/set', data: result.error });
        }
    }

    function update(field, ev) {
        let u1 = Object.assign({}, user);
        u1[field] = ev.target.value;
        setUser(u1);
        store.dispatch({ type: "error/clear" });
    }

    return (
        <div>
            <h2>Login</h2>
            <Form onSubmit={onSubmit}>
                <Form.Group>
                    <Form.Label>Username</Form.Label>
                    <Form.Control type="text" onChange={(ev) => update("username", ev)} value={user.username} />
                </Form.Group>
                <Form.Group>
                    <Form.Label>Password</Form.Label>
                    <Form.Control type="password" onChange={(ev) => update("password", ev)} value={user.password} />
                </Form.Group>
                <Button variant="primary" type="submit"> Submit </Button>
                <Link to="/register">Register</Link>
            </Form>
        </div>
    )
}
