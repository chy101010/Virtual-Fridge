import React, { useState, useEffect } from 'react';
import { makeStyles } from '@material-ui/core/styles';
import Modal from '@material-ui/core/Modal';
import { get_ingredient_by_id } from '../api';

function rand() {
    return Math.round(Math.random() * 20) - 10;
}

function getModalStyle() {
    const top = 50 + rand();
    const left = 50 + rand();

    return {
        top: `${top}%`,
        left: `${left}%`,
        transform: `translate(-${top}%, -${left}%)`,
    };
}

const useStyles = makeStyles((theme) => ({
    paper: {
        position: 'absolute',
        width: 400,
        backgroundColor: theme.palette.background.paper,
        border: '2px solid #000',
        boxShadow: theme.shadows[5],
        padding: theme.spacing(2, 4, 3),
    },
}));

export default function SimpleModal(props) {
    console.log(props.ingredientId);
    const classes = useStyles();
    // getModalStyle is not a pure function, we roll the style only on the first render
    const [modalStyle] = useState(getModalStyle);
    const [open, setOpen] = useState(false);
    const [ingredientId, setIngredientId] = useState();

    const handleOpen = () => {
        setIngredientId(props.ingredientId);
        setOpen(true);
    };

    const handleClose = () => {
        setOpen(false);
    };

    let body = null;

    useEffect(() => {
        let data = {
            "id": ingredientId
        }
        get_ingredient_by_id(data).then((result) => {
        body = (
            <div style={modalStyle} className={classes.paper}>
                <h2 id="simple-modal-title">{result.name}</h2>
                {/* <p id="simple-modal-description">Cost: {ingredient["cost"]["value"]} {ingredient["cost"]["unit"]}</p> */}
                <p id="simple-modal-description">Aisle Location: {result.aisle}</p>
                {/* <p id="simple-modal-description">Aisle Location: {ingredient.nutrition.caloricekdown</p> */}
            </div>);   
        });
    }, [])

    return (
        <div>
            <button type="button" onClick={handleOpen}>
                Info
      </button>
            <Modal
                open={open}
                onClose={handleClose}
                aria-labelledby="simple-modal-title"
                aria-describedby="simple-modal-description"
            >
                {body}
            </Modal>
        </div>
    );
}
