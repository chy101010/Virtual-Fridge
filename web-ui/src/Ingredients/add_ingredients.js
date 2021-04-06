import React, { useEffect, useState } from 'react'
import { useSelector } from 'react-redux';
import { fetch_ingredients } from '../api'
import { Button } from 'react-bootstrap';
import { create_ingredient, create_owned_ingredient } from '../api';

export default function AddIngredients() {
    let ingredients = useSelector(state => state.ingredients);
    let [search, setSearch] = useState("");
    const [ingredientsSearch, setIngredientsSearch] = useState([]);
    const [newIngredient, setNewIngredient] = useState("");

    useEffect(() =>{
        fetch_ingredients();
    }, [])

    let ingrs = ingredientsSearch.map((i) => (
        <li key={i.id}> 
            {i.ingredient_name}
            <Button>Add</Button>
        </li>
    ));

    function setSearched(e) {
        setSearch(e.target.value);
    }

    function setNewIngr(e) {
        setNewIngredient(e.target.value);
    }

    function filterIngredients() {
        let inp = search.toUpperCase();
        let newList = ingredients;
        setIngredientsSearch(newList.filter(ingredient => {
            let ing = ingredient.ingredient_name.toUpperCase();
            return ing.includes(inp);
        }))
    }
    
    function addNewIngredient() {
        let data = {
            ingredient_name: newIngredient
        }    
        create_ingredient(data);
    }

    return (
        <div >
            <h3>Add Ingredients</h3>
            <input type="text" id="ingredientSearch" onChange={(e) => {setSearched(e)}} placeholder="Search for ingredients.." />
            <Button onClick={filterIngredients}>search</Button>
            <ul id="myUL ">
                {ingrs}
            </ul>
            <p>Can't find what you're looking for? Add a new Ingredient below.</p>
            <input type="text" id="addIngredient" onChange={(e) => setNewIngr(e)} placeholder="New Ingredient" />
            <Button onClick={addNewIngredient}>Add</Button>
        </div>
    )
}