const express = require('express');
const app = express();
const cors = require('cors');
require('dotenv').config();
require('./db/connection'); 

// Import routes
const orderRoutes = require('./routes/router.js'); 

app.use(cors())
app.use(express.json());

// Routes
app.use('/api', orderRoutes); 


// Test route
app.get('/', (req, res) => {
  res.send('Hello World!');
});

// Server listen
const PORT = process.env.PORT || 4002;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
