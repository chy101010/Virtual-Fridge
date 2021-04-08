import React, { useState, useEffect, useRef } from 'react';
import { useSelector } from "react-redux";
import Login from '../Login/login'

import { set_callback, state_update } from '../Socket/socket'

export default function Home() {
    const session = useSelector(state => state.session)
    const lives = useSelector(state => state.lives)
    const [state, setState] = useState(lives)

    const topRef = useRef();
    const scrollToTop = () => {
        topRef.current.scrollIntoView({
		behavior: "smooth",
		block: "start",
	});
    };
    useEffect(() => {
        set_callback(setState);
        state_update();
	scrollToTop();
    })

    let ingredients = state.ingredients;
    let recipes = state.recipes;
    let ingredientsFeed = [];
    let recipesFeed = [];
	console.log(state);

    if (ingredients) {
      ingredientsFeed = ingredients.map((item) => (
        <tr>
          <td className="feed-cell"><span className="userName">{item.username}</span> added <span className="ingredientName">{item.ingredient_name}</span> to the ingredients list!</td>
        </tr>
       ));

      ingredientsFeed = ingredientsFeed.reverse();
    } else {
      ingredientsFeed = <tr>
	<td>No Recent Ingredient Activity</td>
      </tr>;
    }

    if (recipes) {
      recipesFeed = recipes.map((item) => (
        <tr>
          <td className="feed-cell"><span className="userName">
	      {item.username}
	      </span> made <span className="recipeName">
	      {item.recipe_name}
	      </span></td>
        </tr>
       ));

      recipesFeed = recipesFeed.reverse();
    } else {
	recipesFeed = <tr>
	<td>No Recent Recipe Activity</td>
      </tr>;
    }

    if (session) {
        return (
	    <div>
	      <div ref={topRef}></div>
              <h2>Can you smell what the rock is cooking?</h2>
		
		<table className="feed-container">
                <tr>
		  <th className="feed-table">
       	          <table className="table">
		    <thead>
		      <tr>
		        <th className="feed-title">Ingredient Feed</th>
		      </tr>
		    </thead>
		    <tbody>
		      <th>
		        { ingredientsFeed }
		      </th>
		    </tbody>
	          </table>
                  </th>

		  <th className="feed-table">
                  <table className="table">
		      <thead>
		        <tr>
		         <th className="feed-title">Recipe Feed</th>
		        </tr>
		      </thead>
		      <tbody>
		        <th className="align-top">
		          { recipesFeed }
		        </th>
		    </tbody>
	          </table>
		  </th>
		</tr>
		</table>

	    </div>
        );
    }
    else {
        return <Login />
    }
}
