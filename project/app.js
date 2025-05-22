const express = require('express');
const cors = require('cors');
const api = require('./routes/api');

const app = express();

app.use(cors());
app.use(express.json());
app.use('/api', api);

app.listen(3000, () => {
  console.log('Server running on http://localhost:3000');
});