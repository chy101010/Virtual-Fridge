import store from './store';

function get_token() {
  let state = store.getState();
  return state.session.token;
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

  let resp = await text.json();
  return resp.data;
}

export function fetch_ingredients() {
  api_get("/ingredients").then((data) => store.dispatch({
    type: 'ingredients/set',
    data: data,
  }));
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
