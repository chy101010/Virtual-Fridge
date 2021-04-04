import React from 'react';
import { Container, Row, Col } from 'react-bootstrap';
import { Switch, Route } from 'react-router-dom';
import UsersNew from './Users/New';
import UsersList from './Users/List';
import ShowIngredients from './Ingredients/Show';
import Mock from './Ingredients/Mock'
import Nav from './Nav';
import Home from './Home';
import './App.scss';
import 'bootstrap/dist/css/bootstrap.min.css';

function App() {
    return (
      <Container>
	<Nav />
	<Row>
	<Col md={10}>
        <Switch>
          <Route path="/" exact>
            <Home />
	  </Route>
	  <Route path="/users" exact>
	    <UsersList />
	  </Route>
	  <Route path="/users/new" exact>
	    <UsersNew />
	  </Route>
	  <Route path="/ingredients" exact>
	    <ShowIngredients />
	  </Route>
	  <Route path="/mock" exact>
		  <Mock />
	  </Route>
	</Switch>
	</Col>
        <Col>
	  <h4>Your Friends</h4>
	</Col>
	</Row>
      </Container>
    );
}

export default App;
