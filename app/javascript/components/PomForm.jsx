import React, {useEffect, useState} from 'react';
import Timer from './Timer';

function PomForm(props) {
  const initValue = {
    task: "",
    notes: "",
  };

  const [formState, setFormState] = useState(initValue);

  const handleChange = function(event) {
    event.preventDefault();
    setFormState((currentState) => {
      return {...currentState, [event.target.name]: event.target.value};
    });
  };

  const handleSubmit = function(event) {
    if (event) {
      event.preventDefault();
    }
    if (!formState.task) {
      return;
    }

    fetch('/api/v1/pomodoros', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': props.csrf,
        'Authorization': `Bearer ${props.token}`
      },
      body: JSON.stringify({...formState, user_id: props.user.user_id})
    })
    .then((response) => {
      console.log(response);
      setFormState(initValue);
    });
  };

  return (
    <div className="pom-form-container">
      <Timer handleFinish={handleSubmit} />
      <form className="pom form">
        <label htmlFor="task">Task</label>
        <input type="text" name="task" value={formState.task} onChange={handleChange} />

        <label htmlFor="notes">Notes</label>
        <textarea name="notes" value={formState.notes} onChange={handleChange}></textarea>
      </form>
    </div>
  );
};

export default PomForm;
