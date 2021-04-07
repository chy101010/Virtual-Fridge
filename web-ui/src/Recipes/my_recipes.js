import React from "react";
import { Button } from 'react-bootstrap';
import { fetch_recipes } from "../api";
import { useSelector } from 'react-redux';
import { useState, useEffect } from 'react';

export default function ShowRecipes() {
    const recipeList = useSelector(state => state.recipes);

    let recipes = recipeList.map((recipe) => (
        <li>
            <p>{recipe.title}</p>
        </li>
      ));


    useEffect(() =>{
        console.log("effect")
        fetch_recipes();
    }, [])

    function loadRecipes() {
        fetch_recipes();
    }

    return (
        <div>
            <h3>Here Are Your Recipes</h3>
            <Button onClick={loadRecipes}>Refresh</Button>
            <ul>
                {recipes}
            </ul>
        </div>
    )
}