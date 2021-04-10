import React, { useState } from 'react'
import { search_ingredient_by_name } from '../api'
import { useSelector } from 'react-redux';
import store from '../store'
import SearchBar from 'material-ui-search-bar';
import InteractiveListIng from './list_query_ingredients';
import FastfoodIcon from '@material-ui/icons/Fastfood';

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

    //query result text if there are no results
    const [queryText, setQueryText] = useState("");

    //current session
    const session = useSelector(state => state.session);

    //get search results from Spoonacular database and set state
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
            if (result.results.length == 0) {
	        setQueryText("No Results");
	    }
	    let action = { type: 'error/clear' };
	    store.dispatch(action);
        })
    }

    function QueryLabel() {
        return (
            <div>
		<h1>{queryText}</h1>
	    </div>
	)
    }

    function handleSearch() {
        getSearchResults();
        setClicked(!clicked);
    }
    
    if (session) {
        return (
            <div className="myDiv">
                <div className="bg"> </div>
                <div id="searchBarAddIng" className="mx-auto">
                    <h3 className="mt-3"><FastfoodIcon />Explore New Ingredients</h3>
                    <p>Can't find what you're looking for? Try looking at the Spoonacular database.</p>
                    <SearchBar style={{ width: "50%" }} value={newIngredientSearch} onChange={(e) => setNewIngredientSearch(e)} onRequestSearch={handleSearch} placeholder="New Ingredient" onCancelSearch={(e) => {setNewIngredientQuery([]); setQueryText("")}} />
                </div>
                <div className="mt-5">
                    <ul id="searchUL">
                        <InteractiveListIng ingredients={newIngredientQuery} />
                    </ul>
                </div>
		<QueryLabel />
            </div>
        )
    } else {
        let action = {
            type: "error/set",
            data: "Required Login! Go to Home!"
        }
        store.dispatch(action);
        return <div> </div>
    }
}
