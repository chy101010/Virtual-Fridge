import React, { useState } from 'react'
import { search_ingredient_by_name, get_ingredient_by_id } from '../api'
import { Button } from 'react-bootstrap';
import { create_ingredient } from '../api';
import { confirmAlert } from 'react-confirm-alert';


export default function AddIngredients() {
    const [newIngredientSearch, setNewIngredientSearch] = useState("");
    const [newIngredientQuery, setNewIngredientQuery] = useState([]);

    let newIngrs = newIngredientQuery.map((i) => (
        <li key={i.id}> 
            {titleCase(i.name)}
            <Button onClick={() => addNewIngredient(i)}>Add</Button>
            <Button onClick={() => getIngredientInfo(i.id)}>Info</Button>
        </li>
    ));

    function getIngredientInfo(id) {
        let data = {
            "id": id
        }
        get_ingredient_by_id(data).then((result) => {
            console.log(result);
            confirmAlert({
                title: `${titleCase(result.name)}`,
                message: [`Cost: ${result.cost.value} ${result.cost.unit} / ${result.unit} \\n`,
                          `Aisle location: ${result.aisle} \\n`],
                buttons: [
                    {
                        label: 'Close.'
                    }
                ],
                closeOnEscape: true,
                closeOnClickOutside: true,
            });
        });
    }

    function titleCase(str) {
        var splitStr = str.toLowerCase().split(' ');
        for (var i = 0; i < splitStr.length; i++) {
            // You do not need to check if i is larger than splitStr length, as your for does that for you
            // Assign it back to the array
            splitStr[i] = splitStr[i].charAt(0).toUpperCase() + splitStr[i].substring(1);     
        }
        // Directly return the joined string
        return splitStr.join(' '); 
    }

    function addNewIngredient(ingredient) {
        let data = {
            ingredient_name: titleCase(ingredient.name),
            spoonacular_id: ingredient.id
        }
        create_ingredient(data);
    }

    function setNewIngrSearch(e) {
        setNewIngredientSearch(e.target.value);
    }
    
    function getSearchResults() {
        let data = {
            ingredient_name: newIngredientSearch
        }    
        search_ingredient_by_name(data).then((result) => {
            let arr = [];
            result.results.forEach(i => {
                arr.push({
                    "name": i.name,
                    "id": i.id
                });
            });
            setNewIngredientQuery(arr);
        })
    }

    return (
        <div >
            <h3>Add Ingredients</h3>
            
            <p>Can't find what you're looking for? Try looking at the Spoonacular database.</p>
            <input type="text" id="addIngredient" onChange={(e) => setNewIngrSearch(e)} placeholder="New Ingredient" />
            <Button onClick={getSearchResults}>search</Button>
            <ul id="searchUL">
                {newIngrs}
            </ul>
        </div>
    )
}