'use strict'

const express = require('express')
const bodyParser = require('body-parser')

// Create a new instance of express
const router = express.Router();
const app = express()

// Tell express to use the body-parser middleware and to not parse extended bodies
app.use(bodyParser.urlencoded({ extended: false }))

// Route that receives a POST request to /sms
router.post('handle',(req, res) =>{
  const body = req.body.Body
  res.set('Content-Type', 'text/plain')
  res.send(`You sent: ${body} to Express`)
  console.log(request.body);
})

// Tell our app to listen on port 5000
app.listen(5000,() =>{
  console.log('Server started on port 5000')
})

app.use("/", router);