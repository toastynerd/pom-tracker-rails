import React, {useState, useEffect} from 'react';
import PomForm from './PomForm';

function PomList(props) {
  const [poms, setPoms] = useState([]);

  const addPom = function(pom) {
    setPoms((currentPoms) => {
      return [...poms, pom];
    });
  };

  useEffect(() => {
    fetch('/api/v1/pomodoros', {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': props.csrf,
        'Authorization': `Bearer ${props.token}`
      }
    })
    .then(response => response.json())
    .then(data => {
      console.log(data);
      setPoms(data)
    });
  }, []);
  
  return (
    <div>
      <PomForm csrf={props.csrf} token={props.token} user={props.user} addPom={addPom} />
      <ul className="pom list">
        {
          poms.map(pom => {
            return <li key={pom.id}>{pom.task} on {pom.created_at}</li>
          })
        }
      </ul>
    </div>
  );
};

export default PomList;
