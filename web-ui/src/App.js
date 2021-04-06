import React from 'react';
import { Container } from 'react-bootstrap';
import { Switch, Route } from 'react-router-dom';
// Style
import './App.scss';

// Components
import Register from './Register/register';
import Login from './Login/login';
import Home from './Home/home';

import UsersList from './Users/List';
import ShowIngredients from './Ingredients/Show';
import Mock from './Ingredients/Mock'
import Nav from './Nav/nav';

function App() {
	return (
		<Container>
			<Nav />
			<Switch>
				<Route path="/" exact>
					<Home />
				</Route>
				<Route path="/login" exact>
					<Login />
				</Route>
				<Route path="/register" exact>
					<Register />
				</Route>
				<Route path="/users" exact>
					<UsersList />
				</Route>
				<Route path="/ingredients" exact>
					<ShowIngredients />
				</Route>
				<Route path="/mock" exact>
					<Mock />
				</Route>
			</Switch>
		</Container>
	);
}

export default App;
