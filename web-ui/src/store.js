import { createStore, combineReducers } from 'redux';

function save_session(sess) {
  let session = Object.assign({}, sess, {time: Date.now()});
  localStorage.setItem("session", JSON.stringify(session));
}
  
export function restore_session() {
  let session = localStorage.getItem("session");
  if (!session) {
    return null;
  }
  session = JSON.parse(session);
  let age = Date.now() - session.time;
  let hours = 60 * 60 * 1000;
  if (age < 24 * hours) {
    return session;
  }
  else {
    return null;
  }
}

function remove_session() {
  localStorage.removeItem("session");
}

function users(state = [], action) {
    switch (action.type) {
    case 'users/set':
        return action.data;
    default:
        return state;
    }
}

// #TODO remode
function user_form(state = {}, action) {
    switch (action.type) {
    case 'user_form/set':
        return action.data;
    default:
        return state
    }
}
 
function session(state = restore_session(), action) {
  switch (action.type) {
    case 'session/set':
      save_session(action.data);
      return action.data;
    case 'session/clear':
      remove_session();		  
      return null;
    default:
      return state;
  }
}

function ingredients(state = [], action) {
  switch (action.type) {
    case 'ingredients/set':
      return action.data;
    default:
      return state;
  }
}

function ownedingredients(state = [], action) {
  switch (action.type) {
    case 'ownedingredients/set':
      return action.data;
    case 'ownedingredients/add':
      state.push(action.data)
      return state
    default:
      return state;
  }
}

function recipes(state = [], action) {
  switch (action.type) {
    case 'recipes/set':
      return action.data;
    case 'recipes/clear':
      return [];
    default:
      return state;
  }
}
 
function error(state = null, action) {
  switch (action.type) {
    case 'session/set':
      return null;
    case 'error/set':
      return action.data;
    case 'error/clear':
      return null;
    default:
      return state;
  }
}

function success(state = null, action) {
  switch (action.type) {
    case "success/set":
      return action.data
    case "error/set":
      return null;
    default:
      return state;
  }
}

function lives(state = [], action) {
  switch(action.type) {
    case "lives/set":
      return action.data;
    default:
      return state;
  }
}
 
function root_reducer(state, action) {
    let reducer = combineReducers({
        users, user_form, session, error, ingredients, ownedingredients, success, recipes, lives
    });
    return reducer(state, action);
}
 
let store = createStore(root_reducer);
export default store;
