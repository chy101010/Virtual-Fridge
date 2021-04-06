import React, { useEffect, useState } from 'react'
import { useSelector } from 'react-redux';
import { fetch_ingredients, search_ingredient_by_name } from '../api'
import { Button } from 'react-bootstrap';
import SearchBar from './search_bar';
import { create_ingredient, create_owned_ingredient } from '../api';

export default function AddIngredients() {
    let ingredients = useSelector(state => state.ingredients);
    let new_ingredients = [] 
    ingredients.map((i) => {
        new_ingredients.push(
            {
                value: i.id,
                label: i.ingredient_name
            }
        )
    })
    console.log(ingredients);
    let [search, setSearch] = useState("");
    const [ingredientsSearch, setIngredientsSearch] = useState([]);
    const [newIngredientSearch, setNewIngredientSearch] = useState("");

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

    function setNewIngrSearch(e) {
        setNewIngredientSearch(e.target.value);
    }

    function filterIngredients() {
        let inp = search.toUpperCase();
        let newList = ingredients;
        setIngredientsSearch(newList.filter(ingredient => {
            let ing = ingredient.ingredient_name.toUpperCase();
            return ing.includes(inp);
        }))
    }
    
    function getSearchResults() {
        let data = {
            ingredient_name: newIngredientSearch
        }    
        search_ingredient_by_name(data).then(() => {
            console.log("helllllo");
            console.log(data)
        });
    }

    return (
        <div >
            <h3>Add Ingredients</h3>
            <p>Add an ingredient to your virtual fridge! Search through out preset list of up to one thousand ingredients.</p>
            <input type="text" id="ingredientSearch" onChange={(e) => {setSearched(e)}} placeholder="Search for ingredients.." />
            <Button onClick={filterIngredients}>search</Button>
            <ul id="myUL ">
                {ingrs}
            </ul>
            <p>Can't find what you're looking for? Try looking at the Spoonacular database.</p>
            <input type="text" id="addIngredient" onChange={(e) => setNewIngrSearch(e)} placeholder="New Ingredient" />
            <Button onClick={getSearchResults}>search</Button>
            <ul id="searchUL"></ul>
            <SearchBar ingredients = {new_ingredients} />
        </div>
    )
}