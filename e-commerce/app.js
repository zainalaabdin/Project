const express = require('express');
const cors = require('cors');
const api = require('./routes/api');
const path = require('path');

const app = express();

app.use(cors());
app.use(express.json());
app.use('/api', api);

app.use(express.static(path.join(__dirname, 'public')));

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public/index.html'));
});

app.listen(3000, () => {
  console.log('Server running on http://localhost:3000');
});