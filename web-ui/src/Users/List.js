import React from 'react';
import { connect } from 'react-redux';
import { Row, Col } from 'react-bootstrap';
import { Link } from 'react-router-dom';

function UsersList({users}) {
  console.log(users);
  let rows = users.map((user) => (
    <tr key={user.id}>
      <td>{user.first_name} {user.last_name}</td>
      <td>{user.username}</td>
      <td><button onClick={() => window.open("https://www.youtube.com/watch?v=dQw4w9WgXcQ", "_blank")}>Send Request</button></td>
    </tr>
  ));

  return (
    <div>
      <Row>
        <Col>
          <h2>List Users</h2>
          <p>
            <Link to="/users/new">
              New User
            </Link>
          </p>
          <table className="table table-striped">
            <thead>
              <tr>
                <th>Name</th>
	        <th>Username</th>
	        <th>Add Friend</th>
              </tr>
            </thead>
            <tbody>
              { rows }
            </tbody>
          </table>
        </Col>
      </Row>
    </div>
  );

}

function state2props({users}) {
  return { users };
}

export default connect(state2props)(UsersList);
