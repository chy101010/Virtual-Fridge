import React, { useState } from 'react'
import { useSelector } from 'react-redux';

export default function AddIngredients() {
    let ingredients = useSelector(state => state.ingredients);
    let [search, setSearch] = useState("");
    const [ingredientsSearch, setIngredientsSearch] = useState([]);

    let ingrs = ingredientsSearch.map((i) => (
        <li key={i.id}> {i.ingredient_name}</li>
    ));

    function setSearched(e) {
        setSearch(e.target.value);
    }

    function filterIngredients() {
        let inp = search.toUpperCase();
        let newList = ingredients;
        setIngredientsSearch(newList.filter(ingredient => {
            let ing = ingredient.ingredient_name.toUpperCase();
            return ing.includes(inp);
        }))
    }

    function searchButton() {
        
    }


    return (
        <div >
            <h3>Add Ingredients</h3>
            <input type="text" id="ingredientSearch" onChange={(e) => {setSearched(e), filterIngredients()}} placeholder="Search for ingredients.." />
            <ul id="myUL ">
                {ingrs}
            </ul>
        </div>
    )
}