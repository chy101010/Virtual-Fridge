import React from "react";
import { Card, ListGroup, ListGroupItem } from 'react-bootstrap';
import { fetch_recipes, get_recipe_by_id } from "../api";
import { useSelector } from 'react-redux';
import { useEffect } from 'react';

// Store
import store from '../store'

export default function ShowRecipes() {
    const recipeList = useSelector(state => state.recipes);
    const session = useSelector(state => state.session);

    let recipes = [];
    for (let ii = 0; ii < recipeList.length; ii++) {
        recipes.push(
            <Card className="ml-5 mt-2" key={recipeList[ii].id} style={{ width: '20rem' }}>
                <img variant="top" src={recipeList[ii].image} alt="Food" />
                <Card.Body>
                    <Card.Title>{recipeList[ii].title}</Card.Title>
                </Card.Body>
                <ListGroup className="list-group-flush">
                    <ListGroupItem>Missed Ingredients: <span className="text-danger"> {recipeList[ii].unusedIngredients.join(", ")}</span></ListGroupItem>
                    <ListGroupItem>Used Ingredients: <span className="text-success">{recipeList[ii].usedIngredients.join(", ")}</span> </ListGroupItem>
                    <ListGroupItem>Unused Ingredients: <span className="text-warning">{recipeList[ii].unusedIngredients.join(", ")}</span> </ListGroupItem>
                </ListGroup>
                <Card.Body>
                    <Card.Link href="#" onClick={() => fetchSource(recipeList[ii].id)}>Learn More</Card.Link>
                </Card.Body>
            </Card>
        )
    }

    function fetchSource(id) {
        let data = {
            "id": id
        }
        get_recipe_by_id(data).then((result) => {
            window.open(result.sourceUrl, "_blank");
        })
    }

    useEffect(() => {
        if (recipeList.length === 0 && session) {
            fetch_recipes();
        }
    }, [])

    if (session) {
        return (
            <div className="mt-3">
                <h2>What You Can Be Cooking!</h2>
                <div className="mt-4 d-flex flex-wrap justify-content-center">
                    {recipes}
                </div>
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