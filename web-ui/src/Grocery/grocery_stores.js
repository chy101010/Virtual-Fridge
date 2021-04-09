import React, { useState } from 'react'
import { get_grocery_stores, search_ingredient_by_name } from '../api'
import { useSelector } from 'react-redux';
import store from '../store'
import { useSpring, animated } from 'react-spring';
import SearchBar from 'material-ui-search-bar';
import InteractiveListIng from './list_query_ingredients';
import FastfoodIcon from '@material-ui/icons/Fastfood';
import { Button } from 'react-bootstrap';

export default function Stores() {
    const session = useSelector(state => state.session);

    function getStores() {
        let data = {
            latitude: "42.34013356970851",
            longitude: "71.08809088029149"
        }
        get_grocery_stores(data);
    }

    if (session) {
        return (
            <div className="myDiv">
               <h1>WASSUp</h1> 
               <Button onClick={getStores}>Test</Button>
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
