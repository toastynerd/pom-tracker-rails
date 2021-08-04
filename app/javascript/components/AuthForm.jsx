import React, {useState, useEffect} from 'react';
import Timer from './Timer';

function AuthForm(props) {
  const initialFormState = {
    email: '',
    password: '',
    password_confirmation: ''
  };
  const [formState, setFormState] = useState(initialFormState);
  const [action, setAction] = useState('');
  const handleChange = function(event) {
    event.preventDefault();
    setFormState((currentState) => {
      return {...formState, [event.target.name]: event.target.value};
    });
  };

  const handleSubmit = function(event) {
    event.preventDefault();

    fetch(`/api/v1/${action.replace(/ /g, '')}`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': props.csrf,
      },
      body: JSON.stringify(formState)
    })
    .then(response => response.json())
    .then(data => {
      props.setToken(data.token);
      const payload = JSON.parse(atob(data.token.split('.')[1]));
      props.setUser(payload.email);
    });
  };

  return (
    <div>
      <Timer handleFinish={() => console.log('timer done!')} />
      <h2><a onClick={() => setAction('sign in')}>Sign in</a> or <a onClick={() => setAction('sign up')}>Sign up</a> to track tasks!</h2>
      {action &&
        <form onSubmit={handleSubmit}>
          <label htmlFor="email">Email</label>
          <input type="text" name="email" value={formState.email} onChange={handleChange} />

          <label htmlFor="password">Password</label>
          <input type="password" name="password" value={formState.password} onChange={handleChange} />

          {action == 'sign up' && 
            <div>
              <label htmlFor="password_confirmation">Confirmation</label>
              <input type="password" name="password_confirmation" value={formState.password_confirmation} onChange={handleChange} />
            </div>
          }
          <button type="submit">{action}</button>
        </form>
      }
    </div>
  )
};

export default AuthForm;
