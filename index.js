'use strict'

const express = require('express')
const bodyParser = require('body-parser')
const PORT = process.env.PORT || 3000

// Create a new instance of express
const router = express.Router();
const app = express()
var body = ""
var rtime = 0
var msg = ""
var arraystorage = new Array()
var printstring = ""

// Tell express to use the body-parser middleware and to not parse extended bodies
app.use(bodyParser.urlencoded({ extended: false }))

// Route that receives a POST request to /sms
router.get('/',(req, res) =>{
	if(body == ""||rtime ==0){
		printstring='Powering up, Server Online'
	}else{
		let time = new Date(rtime)
		let hour = time.getHours()
		let minute = time.getMinutes()
		let second = time.getSeconds()
		let msecond = time.getMilliseconds()
		printstring='Powering up, Server Online\r\n\r\n'+`You sent: ${body} to server\r\n\r\n`+
		`Receive time: ${hour}:${minute}:${second}.${msecond}\r\n\r\n`}
		
	for(let i=0;i<arraystorage.length;i++){
		let time = new Date(arraystorage[i].rtime)
		let hour = time.getHours()
		let minute = time.getMinutes()
		let second = time.getSeconds()
		let msecond = time.getMilliseconds()
		printstring=printstring+`User: ${arraystorage[i].user} Pass: ${arraystorage[i].pass} 
		Receive time: ${hour}:${minute}:${second}.${msecond}\r\n`
	}
	res.set('Content-Type', 'text/plain')
	res.send(printstring)
})

router.post('/',(req, res) =>{
	rtime =Date.now()
  body = req.body.user
  msg = {user:req.body.user,pass:req.body.password,rtime:rtime}
  arraystorage.push(msg)
  res.set('Content-Type', 'text/plain')
  res.send(`You sent: ${body} to Express`)
  console.log("user: "+req.body.user+" pass: "+req.body.password+" Rtime: "+rtime);
})

// Tell our app to listen on port 5000
app.listen(PORT,() =>{
  console.log('Server started on port 5000')
})

app.use("/", router);