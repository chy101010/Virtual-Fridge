import React from 'react';
import { connect } from 'react-redux';
import { Row, Col, Form, Button } from 'react-bootstrap';
import { useState } from 'react';
import { useHistory } from 'react-router-dom';
import pick from 'lodash/pick';
import store from '../store'
import { create_user } from '../api';


function Register() {
  let history = useHistory();
  const [user, setUser] = useState({username: "", first_name: "", last_name: "", pass1: "", pass2: ""});

  function check_pass(p1, p2) {
    if (p1 !== p2) {
      return "Passwords don't match.";
    }

    if (p1.length < 8) {
      return "Password too short.";
    }

    return "";
  }

  function check_username(username) {
    return (!username) ? "Must enter a username." : "";
  }

  function check_first_name(name) {
    return (!name) ? "Must enter a first name." : "";
  }

  function check_last_name(name) {
    return (!name) ? "Must enter a last name." : "";
  }

  function update(field, ev) {
    let u1 = Object.assign({}, user);
    u1[field] = ev.target.value;
    u1.password = u1.pass1;
    u1.pass_msg = check_pass(u1.pass1, u1.pass2);
    u1.username_msg = check_username(u1.username);
    u1.first_msg = check_first_name(u1.first_name);
    u1.last_msg = check_last_name(u1.last_name);
    setUser(u1);
  }

  function onSubmit(ev) {
    ev.preventDefault();
    let data = pick(user, ['first_name', 'last_name', 'username', 'password']);
    create_user(data).then(() => {
      if(data.error) {
        store.dispatch({type: "error/set", data: data.error});
      }
      else {
        store.dispatch({type: "success/set", data: `Hello ${user.username}, You have successfully registered, and now you can Log In!`});
        history.push("/login");
      }
    });
  }

  return (
    <Row>
      <Col>
        <h2>New User</h2>
        <Form onSubmit={onSubmit}>
	  <Form.Group>
            <Form.Label>First Name</Form.Label>
	    <Form.Control type="text"
	                  onChange={(ev) => update("first_name", ev)}
	                  value={user.first_name} />
	  </Form.Group>
	  <Form.Group>
	    <Form.Label>Last Name</Form.Label>
	    <Form.Control type="text"
	                  onChange={(ev) => update("last_name", ev)}
	                  value={user.last_name} />
	  </Form.Group>
          <Form.Group>
            <Form.Label>Username</Form.Label>
            <Form.Control type="text"
                          onChange={(ev) => update("username", ev)}
                          value={user.username} />
          </Form.Group>
          <Form.Group>
            <Form.Label>Password</Form.Label>
            <Form.Control type="password"
                          onChange={(ev) => update("pass1", ev)}
                          value={user.pass1} />
            <p>{user.pass_msg}</p>
          </Form.Group>
          <Form.Group>
            <Form.Label>Confirm Password</Form.Label>
            <Form.Control type="password"
                          onChange={(ev) => update("pass2", ev)}
                          value={user.pass2 || ""} />
          </Form.Group>
          <Button variant="primary"
                  type="submit"
                  disabled={user.pass_msg !== "" || user.first_msg !== "" || user.last_msg !== "" || user.username_msg !== ""}>
            Save
          </Button>
        </Form>
      </Col>
    </Row>
  );
}

function state2props() {
  return {};
}

export default connect(state2props)(Register);
