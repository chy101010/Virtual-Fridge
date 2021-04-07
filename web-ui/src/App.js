import React from 'react';
import { Container } from 'react-bootstrap';
import { Switch, Route } from 'react-router-dom';
// Style
import './App.scss';

// Components
import Register from './Register/register';
import Login from './Login/login';
import Home from './Home/home';

import ShowRecipes from './Recipes/my_recipes';
import OwnIngredients from './Ingredients/own_ingredients';
import AddIngredients from './Ingredients/add_ingredients';
import Mock from './Ingredients/Mock'
import Nav from './Nav/nav';

// Store
import { restore_session } from './store'
import { ch_join } from "./Socket/socket"
// Socket 
// import 

function App() {
	ch_join();
	restore_session();
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
				<Route path="/ingredients" exact>
					<OwnIngredients />
				</Route>
				<Route path="/ingredients/add" exact>
					<AddIngredients />
				</Route>
				<Route path="/mock" exact>
					<Mock />
				</Route>
				<Route path="/recipes" exact>
					<ShowRecipes />
				</Route>
			</Switch>
		</Container>
	);
}

export default App;
