import React from 'react';
import { useState } from 'react';
import { connect, useSelector } from 'react-redux';

function Ingredients() {
  return (
    <div>
      <LoggedInOrNot />
    </div>
  );
}

let IngredientsDisplay = connect()(({session}) => {

  return (
    <div>
      <h1>Mock Session</h1>
      <h3>Username: {session.username}</h3>
    </div>
  );
});

function LOI({session}) {
  if (session) {
    return <IngredientsDisplay session={session} />	  
  } else {
    return <p>Log in to see Mock.</p>
  }
}

const LoggedInOrNot =  connect(
  ({session}) => ({session}))(LOI);

function state2props() {
  return {};
}

export default connect(state2props)(Ingredients);