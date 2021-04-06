import React from 'react';
import { connect } from 'react-redux';

function Home() {
  return (
    <h2>Can you smell what the rock is cooking?</h2>
  );
}

function state2props() {
  return {};
}

export default connect(state2props)(Home);
