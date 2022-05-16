const express = require('express');
const app = express();
const port = 3300;

app.listen(port, function() {
  console.log(`Example app listening on port ${port}!`)
});

app.get('/Events', function(req, res) {
  res.send('Hello World!')
});

app.post('/Events', (req, res) => {

});


uploadToIPFS = () => {

};

createAllTheTickets = (n_tickets, photo) => {

};

deployContract = () => {

}

