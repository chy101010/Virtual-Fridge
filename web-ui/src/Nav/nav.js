import React from 'react';
import { Nav, Col, Row, Alert, Navbar } from "react-bootstrap"
import { NavLink, useHistory } from 'react-router-dom';
import '../index.css'
// Storage
import store from '../store';

// Redux
import { useSelector } from 'react-redux'

// Socket
import {socket_disconnect} from '../Socket/socket'

function Link({ to, children }) {
    return (
        <Nav.Item>
            <NavLink to={to} exact className="nav-link text-light"
                activeClassName="active">
                {children}
            </NavLink>
        </Nav.Item>
    );
}

export default function MyNav() {
    let history = useHistory();
    const error = useSelector(state => state.error);
    const success = useSelector(state => state.success);
    const session = useSelector(state => state.session);
    let error_row;
    let success_row;
    let user = "unknown";
    let logout_button;
    let links = [];

    function logout() {
        store.dispatch({ type: 'session/clear' });
        store.dispatch({ type: 'success/set', data: 'See you soon!' })
        socket_disconnect();
        history.push("/");
    }


    if (session) {
        user = session.username;
        logout_button = <Nav.Link className="text-warning" onClick={logout} to="/">Log Out</Nav.Link>;
        links.push(<Link key="1" to="/ingredients">Virtual Fridge</Link>)
        links.push(<Link key="2" to="/ingredients/add">Explore New Ingredients</Link>)
        links.push(<Link key="3" to="/recipes">Recipes</Link>)
    }


    if (error) {
        error_row = (
            <Row>
                <Col>
                    <Alert variant="danger">{error}</Alert>
                </Col>
            </Row>
        );
    }

    if (success) {
        success_row = (
            <Row>
                <Col>
                    <Alert variant="success">{success}</Alert>
                </Col>
            </Row>
        );
    }

    

    return (
        <div>
            <Navbar className="bg1" bg="light">
                <Navbar.Brand className="text-info">Cooking App</Navbar.Brand>
                <Nav className="mr-auto">
                    <Link key="0" to="/">Home</Link>
                    { links }
                </Nav>
                <Nav>
                    <Navbar.Text className="text-primary"> Signed in as: {user} </Navbar.Text>
                    {logout_button}
                </Nav>
            </Navbar>
            { error_row || success_row}
        </div>
    )
}
