import React from 'react';
import { useState } from 'react';
import { connect, useSelector } from 'react-redux';
import { create_ingredient, create_owned_ingredient, fetch_ingredients } from '../api';
import { Button } from 'react-bootstrap';

function Ingredients() {
  return (
    <div>
      <LoggedInOrNot />
    </div>
  );
}

function testCreateIngAPI() {
    let data = {
        ingredient_name: "Mock test 2"
    }
    create_ingredient(data);
}

function testCreateOwnedIngAPI() {
    let data = {
        ingredient_name: "Mock test"
    }
    create_owned_ingredient(data);
}

let IngredientsDisplay = connect()(({session}) => {
  const ingredients = useSelector(state => state.ingredients).map((i) => (
    i.ingredient_name	  
  ));
  const users = useSelector(state => state.users).map((u) => (
    u.username
  ));
  
  console.log(ingredients)
  console.log(users)

  return (
    <div>
      <h1>Mock Session</h1>
      <h3>Username: {session.username}</h3>
      <Button onClick={testCreateIngAPI}>Create Ingredient</Button>
      <Button onClick={testCreateOwnedIngAPI}>Create Owned Ingredient</Button>
    </div>
  );
});

function LOI({session}) {
  if (session) {
    return <IngredientsDisplay session={session} />	  
  } else {
    return <p>Log in to see Mock.</p>
  }
}

const LoggedInOrNot =  connect(
  ({session}) => ({session}))(LOI);

function state2props() {
  return {};
}

export default connect(state2props)(Ingredients);