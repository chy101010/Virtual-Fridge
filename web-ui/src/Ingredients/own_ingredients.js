import React from "react";
import { useEffect } from 'react';
import { useSelector } from 'react-redux';

// Components
import SearchBar from './search_bar';
import InteractiveList from './list_ingredient';

import {fetch_owned_ingredients, fetch_ingredients} from '../api';

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

    if (session) {
        return (
            <div className="mt-3">
              <h2>Here Are Your Ingredients</h2>
                <div className="Container">
                  <div className="row justify-content-center">
                    <SearchBar ingredients={display_ingredients} />
                  </div>
                  <div className="row justify-content-center">
                     <InteractiveList ingredients={owned_ingredients}/>
                  </div>
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