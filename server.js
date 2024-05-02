const express = require('express');
const app = express();
const path = require('path');
 
// Middleware to set Cross-Origin Embedder Policy and Cross-Origin Opener Policy headers
app.use(function(req, res, next) {
  res.header("Cross-Origin-Embedder-Policy", "require-corp");
  res.header("Cross-Origin-Opener-Policy", "same-origin");
  res.header("SharedArrayBuffer", "true");
  res.header("Access-Control-Allow-Origin", "*"); // or specify specific origins
  res.header("Access-Control-Allow-Methods", "GET, PUT, POST, DELETE");
  res.header("Access-Control-Allow-Headers", "Content-Type, Authorization");
  next();
});

// Serve static files from the 'public' directory
app.use(express.static(path.join(__dirname)));

// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
