import React, {useState, useEffect} from 'react';
import Timer from './Timer';
import PomForm from './PomForm';
import AuthForm from './AuthForm';
import PomList from './PomList';

function App() {
  const csrf = document.querySelector("meta[name='csrf-token']").getAttribute('content');
  const [token, setToken] = useState('');
  const [user, setUser] = useState(null);

  return (
    <div className="app">
      {user &&
        <PomList csrf={csrf} token={token} user={user} />
      }  
      {!user &&
        <AuthForm csrf={csrf} setToken={setToken} setUser={setUser} />
      }
    </div>
  )
};

export default App;
