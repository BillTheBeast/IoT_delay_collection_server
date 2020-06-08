'use strict'

const express = require('express')
const bodyParser = require('body-parser')
const PORT = process.env.PORT || 3000

// Create a new instance of express
const router = express.Router();
const app = express()

// Tell express to use the body-parser middleware and to not parse extended bodies
app.use(bodyParser.urlencoded({ extended: false }))

// Route that receives a POST request to /sms
router.post('/test',(req, res) =>{
  const body = req.body.user
  res.set('Content-Type', 'text/plain')
  res.send(`You sent: ${body} to Express`)
  console.log("user: "+req.body.user+" pass: "+req.body.password);
})

// Tell our app to listen on port 5000
app.listen(PORT,() =>{
  console.log('Server started on port 5000')
})

app.use("/", router);