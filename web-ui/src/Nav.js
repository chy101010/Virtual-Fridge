import React from 'react';
import { Nav, Row, Col, Form, Button, Alert } from 'react-bootstrap';
import { NavLink } from 'react-router-dom';
import { connect } from 'react-redux';
import { useState } from 'react';
import store from './store';

import { api_login } from './api';

function LoginForm() {
  const [username, setUsername] = useState("");
  const [pass, setPass] = useState("");

  function on_submit(ev) {
    ev.preventDefault();
    api_login(username, pass);
  }

  return (
    <div>
      <Form onSubmit={on_submit} inline>
        <Form.Control name="username"
	              type="text"
	              onChange={(ev) => setUsername(ev.target.value)}
	              value={username} />
        <Form.Control name="password"
    	              type="password"
	              onChange={(ev) => setPass(ev.target.value)}
	              value={pass} />
        <Button variant="primary" type="submit">
          Login
        </Button>
      </Form>
      <Link to="/users/new">Register</Link>
    </div>
  );
}

function LOI({session}) {
  if (session) {
    return <SessionInfo session={session} />;
  } else {
    return <LoginForm />;
  }
}

const LoginOrInfo = connect(
  ({session}) => ({session}))(LOI);

function Link({to, children}) {
  return (
    <Nav.Item>
      <NavLink to={to} exact className="nav-link" activeClassName="active">
        {children}
      </NavLink>
    </Nav.Item>
  );
}

function SessionInfo({session}) {
  function logout(ev) {
    ev.preventDefault();
    store.dispatch({ type: 'session/clear' });
  }

  return (
    <p>
      Logged in as {session.username}
      <Button onClick={logout}>Logout</Button>
    </p>
  );
}

function AppNav({error}) {
  let error_row = null;

  if (error) {
    error_row = (
      <Row>
        <Col>
          <Alert variant="danger">{error}</Alert>
        </Col>
      </Row>
    );
  }
 
  return (
    <div>
      <Row>
        <Col>
          <Nav variant="pills">
            <Link to="/">Feed</Link>
            <Link to="/users">Users</Link>
	    <Link to="/ingredients">Your Ingredients</Link>
          </Nav>
        </Col>
        <Col>
          <LoginOrInfo />
        </Col>
      </Row>
      { error_row }
    </div>
  );
}

export default connect(({error})=>({error}))(AppNav);
