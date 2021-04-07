import React from "react";
import { Button } from "react-bootstrap";
import { useEffect } from 'react';
import { useSelector } from 'react-redux';

// Components
import SearchBar from './search_bar';

import { delete_owned_ingredient, fetch_owned_ingredients, fetch_ingredients} from '../api';

export default function OwnIngredients() {
  const session = useSelector(state => state.session);
  const owned_ingredients = useSelector(state => state.ownedingredients);
  const ingredients = useSelector(state => state.ingredients);
  

  let display_ingredients = [] 
  for(let ii = 0; ii < ingredients.length; ii++) {
    display_ingredients.push(
      {
          value: ingredients[ii].id,
          label: ingredients[ii].ingredient_name
      }
    )
  }

  useEffect(() => {
    fetch_ingredients();
    fetch_owned_ingredients();
  }, [])

  function removeOwnedIngredient(id) {
    let data = {
      "id": id
    }
    delete_owned_ingredient(data);
  }

  let ingrs = owned_ingredients.map((i) => (
        <li key={i.id}> 
            {i.ingredient_name}
            <Button onClick={() => removeOwnedIngredient(i.id)}>remove</Button>
        </li>
    ));

    if (session) {
        return (
            <div>
              <h2>Here Are Your Ingredients</h2>
                <div className="Container">
                  <div className="row justify-content-center">
                    <SearchBar ingredients={display_ingredients} />
                  </div>
                  <ul>
                    {ingrs}
                  </ul>
                </div>
            </div>
        )
    }
    else {
        return (
          <h3>Login to see this page!</h3>
        )
    }
}