import React from "react";
import { useEffect } from 'react';
import { connect, useSelector } from 'react-redux';

import { fetch_owned_ingredients } from '../api';

function OwnIngredients() {
    return (
        <div>
            <h3>Here Are Your Ingredients</h3>
        </div>
    )
}

let ShowIngredients = connect()(({session}) => {
  fetch_owned_ingredients(); 
  const ownedingredients = useSelector(state => state.ownedingredients);
  console.log(ownedingredients);
});

function LOI({session}) {
  if (session) {
    return <ShowIngredients session={session} />
  } else {
    return <p>Log in to see your ingredients.</p>
  }
}

const LoggedInOrNot = connect(
  ({session}) => ({session}))(LOI);

function state2props() {
  return {};
}

export default connect(state2props)(OwnIngredients);
