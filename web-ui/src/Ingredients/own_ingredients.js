import { Button } from "react-bootstrap";
import React from "react";
import { useEffect } from 'react';
import { connect, useSelector } from 'react-redux';

import { delete_owned_ingredient, fetch_owned_ingredients } from '../api';

export default function OwnIngredients() {

  useEffect(() => {
    fetch_owned_ingredients();
  }, [])

  function removeOwnedIngredient(id) {
    let data = {
      "id": id
    }
    delete_owned_ingredient(data);
  }

  const session = useSelector(state => state.session);
  const ingredients = useSelector(state => state.ownedingredients);
  console.log(ingredients);
  let ingrs = ingredients.map((i) => (
        <li key={i.id}> 
            {i.ingredient_name}
            <Button onClick={() => removeOwnedIngredient(i.id)}>remove</Button>
        </li>
    ));

    if (session) {
        return (
            <div>
              <h2>Here Are Your Ingredients</h2>
              <ul>
                {ingrs}
              </ul>
            </div>
        )
    }
    else {
        return (
          <h3>Login to see this page!</h3>
        )
    }
}