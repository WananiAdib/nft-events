import AddEvent from './AddEvent';
import MarketPlace from './marketPlace';
import { Button, Modal } from '@mui/material';
import {useEffect, useState} from 'react';
import WalletBalance from './WalletBalance';

function Home() {
  const [events, setEvents] = useState(null);
  const [createEvent, setCreateEvent] = useState(false);

  
  
  useEffect(() => {
      fetch('http://localhost:8000/Events')
          .then(response => response.json())
          .then(data => {
            console.log(Array.isArray(data))
            setEvents(data)
          });    
      }, []);

  return (
    <div className="App">
      {/* {createEvent ? <AddEvent /> : null} */}
      <Button variant="contained" onClick={() => setCreateEvent(true)} xs={8}>Deploy an event</Button>
      <Modal
        open={createEvent}
        onClose={() => setCreateEvent(false)}>
        <AddEvent toClose={setCreateEvent} />
      </Modal>
      {events ? <MarketPlace events={events} /> : null}
    </div>
  )
}

export default Home