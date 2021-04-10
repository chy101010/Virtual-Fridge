import React from 'react';
import { Container } from 'react-bootstrap';
import { Switch, Route } from 'react-router-dom';
// Style
import './App.scss';

// Components
import Register from './Register/register';
import Login from './Login/login';
import Home from './Home/home';
import Stores from './Grocery/grocery_stores';

import ShowRecipes from './Recipes/my_recipes';
import OwnIngredients from './Ingredients/own_ingredients';
import AddIngredients from './Ingredients/add_ingredients';
import Nav from './Nav/nav';

// Store
import { restore_session } from './store'

// Socket
import { ch_join } from './Socket/socket'

function App() {
	restore_session();
	ch_join();
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
				<Route path="/recipes" exact>
					<ShowRecipes />
				</Route>
				<Route path="/stores" exact>
					<Stores />	
				</Route>
			</Switch>
		</Container>
	);
}

export default App;
