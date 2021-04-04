import React from 'react';
import { useState } from 'react';
import { connect, useSelector } from 'react-redux';

function Ingredients() {
  return (
    <div>
      <LoggedInOrNot />
    </div>
  );
}

let IngredientsDisplay = connect()(({session}) => {
  const ingredients = useSelector(state => state.ingredients).map((i) => (
    i.ingredient_name	  
  ));
  const [search, setSearch] = useState("");
  const [ingredientsSearch, setIngredientsSearch] = useState(ingredients); 
  console.log(ingredients);

  let ingrs = ingredientsSearch.map((i) => (
    <li>
      <a href="#">{i}</a>
      <button>Add</button>
    </li>
  ));

  function setSearched(e) {
    setSearch(e.target.value);
  }

  function filterIngredients() {
    var inp = search.toUpperCase();
    let newList = ingredients.slice();
    for (let index = 0; index < newList.length; index++) {
      let ing = newList[index].toUpperCase();
      if (!ing.includes(inp)) {
        newList[index] = "";
      }
    }

    setIngredientsSearch(newList.filter(str => str.length > 0));
  }

  return (
    <div>
      <h3>Hi {session.username}, here are your ingredients!</h3>
      <p>None</p>

      <h3>Add ingredients below</h3>
      <input type="text" id="ingredientSearch" onChange={setSearched} onKeyUp={() => {filterIngredients()}} placeholder="Search for ingredients.." />
        <ul id="myUL">
	  { ingrs }
	</ul>
    </div>
  );
});

function LOI({session}) {
  if (session) {
    return <IngredientsDisplay session={session} />	  
  } else {
    return <p>Log in to see your ingredients.</p>
  }
}

const LoggedInOrNot =  connect(
  ({session}) => ({session}))(LOI);

function state2props() {
  return {};
}

export default connect(state2props)(Ingredients);
