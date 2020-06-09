'use strict'

const express = require('express')
const bodyParser = require('body-parser')
const fs = require('fs')
const PORT = process.env.PORT || 3000

// Create a new instance of express
const router = express.Router();
const app = express()
var body = ""
var rtime = 0
var msg = `User: ${arraystorage[i].user} | Pass: ${arraystorage[i].pass} |`+
		`Receive time: ${hour}:${minute}:${second}.${msecond}\r\n`
var info = ""
var arraystorage = new Array()
var printstring = ""

// Tell express to use the body-parser middleware and to not parse extended bodies
app.use(bodyParser.urlencoded({ extended: false }))

if(!fs.existsSync('messagelog.txt')){
	fs.writeFile('messagelog.txt', "Logs about the sent massages are below:", function(err)){
	  if(err) throw err;
  }
}

// Route that receives a POST request to /sms
router.get('/',(req, res) =>{
	if(body == ""||rtime ==0){
		printstring='Powering up, Server Online'
	}else{
		let time = new Date(rtime)
		let hour = time.getHours()
		let minute = ("0"+time.getMinutes()).slice(-2)
		let second = ("0"+time.getSeconds()).slice(-2)
		let msecond = time.getMilliseconds()
		printstring='Powering up, Server Online\r\n\r\n'+`You sent: ${body} to server\r\n\r\n`+
		`Receive time: ${hour}:${minute}:${second}.${msecond}\r\n\r\n`}
		
	for(let i=0;i<arraystorage.length;i++){
		let time = new Date(arraystorage[i].rtime)
		let hour = time.getHours()
		let minute = ("0"+time.getMinutes()).slice(-2)
		let second = ("0"+time.getSeconds()).slice(-2)
		let msecond = time.getMilliseconds()
		printstring=printstring+msg
	}
	res.set('Content-Type', 'text/plain')
	res.send(printstring)
})

router.post('/',(req, res) =>{
	rtime =Date.now()
  body = req.body.user
  info = {user:req.body.user,pass:req.body.password,rtime:rtime}
  fs.appendFile('messagelog.txt', msg, function(err)){
	  if(err) throw err;
  }
  arraystorage.push(info)
  res.set('Content-Type', 'text/plain')
  res.send(`You sent: ${body} to Express`)
  console.log("user: "+req.body.user+" pass: "+req.body.password+" Rtime: "+rtime);
})

// Tell our app to listen on port 5000
app.listen(PORT,() =>{
  console.log('Server started on port 5000')
})

app.use("/", router);