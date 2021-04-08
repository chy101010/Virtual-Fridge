import React, { useState } from 'react'
import { search_ingredient_by_name, get_ingredient_by_id } from '../api'
import { useSelector } from 'react-redux';
import store from '../store'
import {useSpring, animated} from 'react-spring';
import SearchBar from 'material-ui-search-bar';
import InteractiveListIng from './list_query_ingredients';

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
        config: {duration: 1000},
        position: 'relative',
        top: clicked? '0px' : '300%',
        opacity: clicked? 1:0, 
        delay: 600
    });

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
                    <InteractiveListIng ingredients={newIngredientQuery} />
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