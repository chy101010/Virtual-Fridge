import { identity } from 'lodash';
import store from './store';

export function get_token() {
  let state = store.getState();
  if(state.session) {
    return state.session.token;
  }
  else {
    return null;
  }
}

export function get_username() {
  let state = store.getState();
  if(state.session) {
    return state.session.username; 
  }
  else {
    return null;
  }
}

export async function api_post_no_auth(path, data) {
  let opts = {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(data),
  };
  let text = await fetch(
    "http://localhost:4000/api/v1" + path, opts);
  return await text.json();
}

export async function api_login(username, password) {
  let data = await api_post_no_auth("/session", { username, password });
  return data;
}


export async function api_get(path) {
  let token = get_token();
  let ops = {
    method: 'GET',
    headers: {
      'x-auth': token,
    }
  };
  let text = await fetch("http://localhost:4000/api/v1" + path, ops);
  return text.json();
}

export async function api_delete(path, data) {
  let token = get_token();
  let opts = {
    method: 'DELETE',
    headers: {
      'Content-Type': 'application/json',
      'x-auth': token
    },
    body: JSON.stringify(data),
  };
  let text = await fetch(
    "http://localhost:4000/api/v1" + path, opts);
  return await text.json();
}

export async function fetch_ingredients() {
  let data = await api_get("/ingredients");
  store.dispatch({
    type: 'ingredients/set',
    data: data.data,
  })
}

export async function fetch_owned_ingredients() {
  let data = await api_get("/owned-ingredients");
  store.dispatch({
    type: 'ownedingredients/set',
    data: data.data
  })
}

export async function fetch_recipes() {
  let data = await api_get("/recipes-by-ingredients");
  console.log("called fetch")
  store.dispatch({
    type: 'recipes/set',
    data: data
  })
}

// Post with out x-auth
// Post with x-auth
export async function api_post(path, data) {
  let token = get_token();
  let opts = {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'x-auth': token
    },
    body: JSON.stringify(data),
  };
  let text = await fetch(
    "http://localhost:4000/api/v1" + path, opts);
  return await text.json();
}

export function create_user(user) {
  return api_post_no_auth("/users", { user });
}

export function create_ingredient(ingredient) {
  return api_post("/ingredients", { ingredient })
}

export function create_owned_ingredient(owned_ingredient) {
  return api_post("/owned-ingredients", { owned_ingredient })
}

export function search_ingredient_by_name(ingredient) {
  return api_post("/ingredients-search", {ingredient})
}

export function get_recipe_by_id(recipe) {
  return api_post("/recipe-by-id", {recipe})
}

export function delete_owned_ingredient(owned_ingredient) {
  return api_delete(`/owned-ingredients/${owned_ingredient.id}`, owned_ingredient)
}

// export function load_defaults() {
//   fetch_users();
//   fetch_ingredients();
// }
// export function fetch_users() {
  //   api_get("/users").then((data) => store.dispatch({
  //     type: 'users/set',
  //     data: data,
  //   }));
  // }
