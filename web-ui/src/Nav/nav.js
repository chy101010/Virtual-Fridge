import React, { useState, useEffect } from 'react';
import { Nav, Col, Row, Alert, Navbar } from "react-bootstrap"
import { NavLink, useHistory } from 'react-router-dom';
import '../index.css'
// Storage
import store from '../store';

// Redux
import { useSelector } from 'react-redux'

// Socket
import { socket_disconnect, set_callback_nav, state_update_nav } from '../Socket/socket'

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

    const lives = useSelector(state => state.lives)
    const [state, setState] = useState(lives)
    useEffect(() => {
      set_callback_nav(setState);
      state_update_nav();
    })


    function logout() {
        store.dispatch({ type: 'session/clear' });
        store.dispatch({ type: 'success/set', data: 'See you soon!' })
        store.dispatch({ type: 'recipes/clear' })
	socket_disconnect();
        history.push("/");
    }


    function clearError() {
      store.dispatch( { type: 'error/clear' });
    }

    if (session) {
        user = session.username;
        logout_button = <Nav.Link className="text-warning" onClick={logout} to="/">Log Out</Nav.Link>;
        links.push(<Link key="1" to="/ingredients" onClick={clearError}>Virtual Fridge</Link>)
        links.push(<Link key="2" to="/ingredients/add" onClick={clearError}>Explore New Ingredients</Link>)
        links.push(<Link key="3" to="/recipes" onClick={clearError}>Recipes</Link>)
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

  let ingredients = state.ingredients;
  let recipes = state.recipes;
  let recentIngredient;
  let recentRecipe;
  let ingredientNavFeed;
  let recipeNavFeed;
  
  if (ingredients && ingredients.length !== 0) {
    recentIngredient = ingredients[ingredients.length - 1];
    ingredientNavFeed =
        <div className="feed-cell"><span className="userName">{recentIngredient.username}</span> added <span className="ingredientName">{recentIngredient.ingredient_name}</span> to the ingredients list!</div>;

  } else {
    ingredientNavFeed = 
    <div className="text-center">No Recent Ingredient Activity</div>;
  }

  if (recipes && recipes.length !== 0) {
    recentRecipe = recipes[recipes.length - 1];
    recipeNavFeed=
        <div className="feed-cell"><span className="userName">
          {recentRecipe.username}
        </span> found <span className="recipeName">
            {recentRecipe.recipe_name}
          </span></div>;

  } else {
    recipeNavFeed = 
	<div className="text-center">No Recent Recipe Activity</div>;
  }


    return (
        <div>
            <Navbar className="bg1" bg="light">
                <Navbar.Brand className="text-info">Cooking App</Navbar.Brand>
                <Nav className="mr-auto">
                    <Link key="0" to="/" onClick={clearError}>Home</Link>
                    { links }
                </Nav>
                <Nav>
                    <Navbar.Text className="text-primary"> Signed in as: {user} </Navbar.Text>
                    {logout_button}
                </Nav>
            </Navbar>

	    <table class="nav-box">
	    <tr>
	    <td>
	      <div className="nav-activity-title">Most Recent Activity</div>
	      <div className="feed-table">{ ingredientNavFeed }</div>
	      <div className="feed-table">{ recipeNavFeed }</div>
	    </td>
	    </tr>
	    </table>

            { error_row || success_row}
        </div>
    )
}
