import React from 'react';
import Timer from './Timer';
import PomForm from './PomForm';

function App() {
  const csrf = document.querySelector("meta[name='csrf-token']").getAttribute('content');
  return (
    <div className="app">
      <PomForm csrf={csrf} />
    </div>
  )
};

export default App;
