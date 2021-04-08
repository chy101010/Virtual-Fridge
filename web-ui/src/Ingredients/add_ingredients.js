import React, { useState } from 'react'
import { search_ingredient_by_name, get_ingredient_by_id } from '../api'
import { Button } from 'react-bootstrap';
import { create_ingredient } from '../api';
import { confirmAlert } from 'react-confirm-alert';
import { useSelector } from 'react-redux';
import store from '../store'
import {useSpring, animated} from 'react-spring';
import SearchBar from 'material-ui-search-bar';

function getIngredientInfo(id) {
    let data = {
        "id": id
    }
    get_ingredient_by_id(data).then((result) => {
        confirmAlert({
            title: `${titleCase(result.name)}`,
            childrenElement: () => 
            
            <div>
                <p>Cost: {result.cost.value} {result.cost.unit}</p>
                <p>Aisle Location: {result.aisle}</p>
                <p>Caloric Breakdown:</p>
                <ul>
                    <li>Protein %: {result.nutrition.caloricBreakdown.percentProtein}</li>
                    <li>Fat %: {result.nutrition.caloricBreakdown.percentFat}</li>
                    <li>Carbs %: {result.nutrition.caloricBreakdown.percentCarbs}</li>
                </ul>
            </div>,
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

//converts string to title case. 
//example: "hello there" to "Hello There"
export function titleCase(str) {
    var splitStr = str.toLowerCase().split(' ');
    for (var i = 0; i < splitStr.length; i++) {
        // You do not need to check if i is larger than splitStr length, as your for does that for you
        // Assign it back to the array
        splitStr[i] = splitStr[i].charAt(0).toUpperCase() + splitStr[i].substring(1);     
    }
    // Directly return the joined string
    return splitStr.join(' '); 
}


export default function AddIngredients() {
    //Query string when searching for a new ingredient
    const [newIngredientSearch, setNewIngredientSearch] = useState("");

    //List of new ingredients from the query
    const [newIngredientQuery, setNewIngredientQuery] = useState([]);

    const [clicked, setClicked] = useState(false);

    //current session
    const session = useSelector(state => state.session);

    const moveUp = useSpring ({
        config: {duration: 700},
        opacity: clicked ? 0: 1,
        position: 'relative',
        top: clicked? '-275%' : '0px',
        delay: 200
    });

    const moveIn = useSpring ({
        config: {duration: 1500},
        position: 'relative',
        opacity: clicked ? 1: 0,
        delay: 400
    })

    //create a list of new ingredients with an add and info button
    let newIngrs = newIngredientQuery.map((i) => (
        <li key={i.id}> 
            {titleCase(i.name)}
            <Button onClick={() => addNewIngredient(i)}>Add</Button>
            <Button onClick={() => getIngredientInfo(i.id)}>Info</Button>
        </li>
    ));

    //makes a post request to add a new ingredient into our database
    function addNewIngredient(ingredient) {
        let data = {
            ingredient_name: titleCase(ingredient.name),
            spoonacular_id: ingredient.id
        }
        create_ingredient(data);
    }
    
    //get search results from Spoonacular database and set state
    function getSearchResults() {
        console.log("search")
        console.log(newIngredientSearch)
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

    function handleSearch() {
        getSearchResults();
        setClicked(!clicked);
    }

    if (session) {
        return (
            <div >
                <h3>Add Ingredients</h3>
                <div style={{top: "50%", left: "15%", position: "fixed", width: "70%"}}>
                    <animated.div id="searchBarAddIng" style={moveUp}>
                        <p>Can't find what you're looking for? Try looking at the Spoonacular database.</p>
                        <SearchBar value={newIngredientSearch} onChange={(e) => setNewIngredientSearch(e)} onRequestSearch={handleSearch} placeholder="New Ingredient" onCancelSearch={(e) => setNewIngredientQuery([])}/>
                    </animated.div>
                </div>
                <animated.ul id="searchUL" style={moveIn}>
                    {newIngrs}
                </animated.ul>
            </div>
        )
    } else{
        let action = {
            type: "error/set",
            data: "Required Login! Go to Home!"
        }
        store.dispatch(action);
        return <div> </div>
    }
}