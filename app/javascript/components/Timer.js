import React, {useEffect, useState} from 'react';

function Timer(props) {
  const initSeconds = 10; //25 minutes worth of seconds
  const [seconds, setSeconds] = useState(initSeconds);
  const [isActive, setIsActive] = useState(false);
  let timeout;

  useEffect(() => {
    if (isActive && seconds) {
      timeout = setTimeout(() => {
        setSeconds(seconds - 1);
      }, 1000);
    } 

    if (seconds === 0 && isActive) {
      clearTimeout(timeout);
      setIsActive(false);
      props.handleFinish();
    }

  }, [isActive, seconds]);

  const toggle = function() {
    if (isActive) clearTimeout(timeout);
    setIsActive(!isActive);
  };

  const reset = function() {
    clearTimeout(timeout);
    setSeconds(initSeconds);
  };

  return (
    <div className="timer-container">
      <div className="time-left">
        <span className="minutes">
          {Math.floor(seconds / 60)}
        </span>:
        <span className="seconds">
          {Math.floor(seconds % 60).toString().padStart(2, '0')}
        </span>
      </div>
      <button 
        className="button start"
        onClick={toggle}
      >
        {isActive? 'Pause' : 'Start'} Timer
      </button>
      <button
        className="button reset"
        onClick={reset}
      >
        Reset Timer
      </button>
    </div>
  )
};

export default Timer;
