import React from 'react';
import { connect } from 'react-redux';

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
      <h3>Hi {session.username}, here are your ingredients!</h3>

    </div>
  );
});

function LOI({session}) {
  if (session) {
    return <IngredientsDisplay session={session} />	  
  } else {
    return <p>Log in to see your ingredients.</p>
  }
}

const LoggedInOrNot =  connect(
  ({session}) => ({session}))(LOI);

function state2props() {
  return {};
}

export default connect(state2props)(Ingredients);
