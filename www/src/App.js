import React from 'react';

function App() {
  return (
    <div>
      <h1>Hello {process.env.REACT_APP_NAME}</h1>
    </div>
  );
}

export default App;
