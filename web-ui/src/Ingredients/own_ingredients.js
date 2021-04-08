import React from "react";
import { useEffect, useState } from 'react';
import { useSelector } from 'react-redux';
import FastfoodIcon from '@material-ui/icons/Fastfood';
import Typography from '@material-ui/core/Typography';
import blue from '@material-ui/core/colors/blue';
import { useStyles } from "./list_ingredient"
import '../index.css'

// Components
import SearchBar from './search_bar';
import InteractiveList from './list_ingredient';

// Store
import store from '../store'

import { fetch_owned_ingredients, fetch_ingredients } from '../api';

export default function OwnIngredients() {
  const classes = useStyles();
  const session = useSelector(state => state.session);
  const owned_ingredients = useSelector(state => state.ownedingredients);
  const [state, setState] = useState(false);
  const ingredients = useSelector(state => state.ingredients);

  let display_ingredients = []
  for (let ii = 0; ii < ingredients.length; ii++) {
    display_ingredients.push(
      {
        value: ingredients[ii].id,
        label: ingredients[ii].ingredient_name
      }
    )
  }
  
  useEffect(() => {
    if (session) {
      fetch_owned_ingredients();
      fetch_ingredients();
    }
  }, [state])

  if (session) {
    return (
      <div className="mt-3 myDiv">
        <div className="bg"> </div>
        <h2><FastfoodIcon />Ingredients</h2>
        <p>Select An Ingredient From Our Database And Add It To Your Virtual Fridge!</p>
        <div className="Container">
          <div className="row justify-content-center">
            <SearchBar ingredients={display_ingredients} flag={state} callback={setState} />
          </div>
          <Typography variant="h4" className={classes.title} style={{ color: blue[300] }}>  Virtual Fridge </Typography>
          <div className="row justify-content-center">
            <InteractiveList ingredients={owned_ingredients} flag={state} callback={setState} />
          </div>
        </div>
      </div>
    )
  }
  else {
    let action = {
      type: "error/set",
      data: "Required Login! Go to Home!"
    }
    store.dispatch(action);
    return <div> </div>
  }
}