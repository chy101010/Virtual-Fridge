// Cited: https://material-ui.com/getting-started/installation/
import React from 'react';
import { makeStyles } from '@material-ui/core/styles';
import List from '@material-ui/core/List';
import ListItem from '@material-ui/core/ListItem';
import ListItemAvatar from '@material-ui/core/ListItemAvatar';
import ListItemSecondaryAction from '@material-ui/core/ListItemSecondaryAction';
import ListItemText from '@material-ui/core/ListItemText';
import Avatar from '@material-ui/core/Avatar';
import IconButton from '@material-ui/core/IconButton';
import KitchenTwoToneIcon from '@material-ui/icons/KitchenTwoTone';
import ContactSupportRoundedIcon from '@material-ui/icons/ContactSupportRounded';
import AddIcon from '@material-ui/icons/Add';
import green from '@material-ui/core/colors/green';
import { titleCase } from './add_ingredients';
import { confirmAlert } from 'react-confirm-alert';
import { create_ingredient } from '../api';


import { delete_owned_ingredient, get_ingredient_by_id } from '../api';

export const useStyles = makeStyles((theme) => ({
    root: {
        flexGrow: 1,
        maxWidth: 752,
    },
    demo: {
        backgroundColor: theme.palette.background.paper,
    },
    title: {
        margin: theme.spacing(4, 0, 2),
    },
}));

function getIngredientInfo(id) {
    let data = {
        "id": id
    }
    get_ingredient_by_id(data).then((result) => {
        console.log(result);
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

//makes a post request to add a new ingredient into our database
function addNewIngredient(ingredient) {
    let data = {
        ingredient_name: titleCase(ingredient.name),
        spoonacular_id: ingredient.id
    }
    create_ingredient(data);
}

export default function InteractiveListIng({ ingredients }) {
    console.log(ingredients);
    const classes = useStyles();
    let ingredients_row = [];
    for (let ii = 0; ii < ingredients.length; ii++) {
        ingredients_row.push(
            <ListItem key={ingredients[ii].id}>
                <ListItemAvatar>
                    <Avatar>
                        <KitchenTwoToneIcon style={{ color: green[500] }} />
                    </Avatar>
                </ListItemAvatar>
                <ListItemText
                    primary={titleCase(ingredients[ii].name)}
                />
                <ListItemSecondaryAction>
                    <IconButton edge="end" aria-label="delete" onClick={() => addNewIngredient(ingredients[ii])}>
                        <AddIcon />
                    </IconButton >
                    <IconButton edge="end" aria-label="delete" onClick={() => getIngredientInfo(ingredients[ii].id)}>
                        <ContactSupportRoundedIcon />
                    </IconButton>
                </ListItemSecondaryAction>
            </ListItem>
        )
    }

    return (
        <div className={classes.root}>
            <div className={classes.demo}>
                <List>
                    {ingredients_row}
                </List>
            </div>
        </div>
    );
}