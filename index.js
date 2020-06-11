'use strict'

const express = require('express')
const bodyParser = require('body-parser')
const fs = require('fs')
const readline =require('readline')
//const {Pool} = require('pg')
const PORT = process.env.PORT || 80

// Create a new instance of express
const router = express.Router();
const app = express()
var body = ""
var rtime = 0
var info = ""
var arraystorage = new Array()
var printstring = ""

// Tell express to use the body-parser middleware and to not parse extended bodies
app.use(bodyParser.urlencoded({ extended: false }))

/*const pool = new Pool({
	connectionString: process.env.DATABASE_URL,
	ssl:{
		rejectUnauthorized: false
	}
})*/

async function processLineByLine(){
	const fileStream = fs.createReadStream('messagelog.txt')
		
		const rl = readline.createInterface({
			input: fileStream,
			crlfDelay: Infinity
		})
		
		for await (const line of rl){
			const data = line.split('|')
			if(data.length < 2){
				continue
			}else{
				console.log("user: "+data[0]+" pass: "+data[1]+" Rtime: "+data[2]);
				info = {user:data[0],pass:data[1],rtime:parseInt(data[2]),id:data[3],data:data[4],stime:parseInt(data[5])}
				arraystorage.push(info)
			}
		}
}

/*const client = await pool.connect()
client.query("IF(EXISTS(SELECT *
						FROM INFORMATION_SCHEMA.TABLES
						WHERE TABLE_SCHEMA = ''
))")

const result = await client.query('SELECT * FROM msg_table')*/

if(!fs.existsSync('messagelog.txt')){
	fs.writeFile('messagelog.txt', "Logs about the sent massages are below:\n", function(err){
	  if(err) throw err;
  })
}else{
	processLineByLine()
}

// Route that receives a GET request 
router.get('/',(req, res) =>{
	if(rtime ==0){
		printstring='Powering up, Server Online\r\n\r\n'
	}else{
		let time = new Date(rtime)
		let hour = time.getHours()
		let minute = ("0"+time.getMinutes()).slice(-2)
		let second = ("0"+time.getSeconds()).slice(-2)
		let msecond = time.getMilliseconds()
		printstring='Powering up, Server Online\r\n\r\n'+`Last message received at: ${hour}:${minute}:${second}.${msecond}\r\n\r\n`}
		
	for(let i=0;i<arraystorage.length;i++){
		let time = new Date(arraystorage[i].rtime)
		let hour = time.getHours()
		let minute = ("0"+time.getMinutes()).slice(-2)
		let second = ("0"+time.getSeconds()).slice(-2)
		let msecond = time.getMilliseconds()
		let delay = arraystorage[i].rtime-arraystorage[i].stime
		printstring=printstring+`User: ${arraystorage[i].user} | Pass: ${arraystorage[i].pass} | `+
		`Receive time: ${hour}:${minute}:${second}.${msecond} | Id: ${arraystorage[i].id} | `+
		`Data: ${arraystorage[i].data} | Sent time: ${arraystorage[i].stime} | Delay: ${delay}\r\n`
	}
	res.set('Content-Type', 'text/plain')
	res.send(printstring)
})

router.get('/rcv',(req, res) =>{
	rtime =Date.now()
  info = {user:req.query.user,pass:req.query.password,rtime:rtime,id:req.query.device,data:req.query.data,stime:req.query.stime}
  fs.appendFile('messagelog.txt', `${info.user}|${info.pass}|`+
		`${info.rtime}|${info.id}|${info.data}|${info.stime}\r\n`, function(err){
	  if(err) throw err;
  })
  arraystorage.push(info)
  console.log("user: "+req.query.user+" pass: "+req.query.password+" Rtime: "+rtime+
  "id: "+req.query.device+" data: "+req.query.data+" Stime: "+req.query.stime);
})

// Route that receives a POST request 
router.post('/rcv',(req, res) =>{
	rtime =Date.now()
  info = {user:req.body.user,pass:req.body.password,rtime:rtime,id:req.body.device,data:req.body.data,stime:req.body.stime}
  fs.appendFile('messagelog.txt', `${info.user}|${info.pass}|`+
		`${info.rtime}|${info.id}|${info.data}|${info.stime}\r\n`, function(err){
	  if(err) throw err;
  })
  arraystorage.push(info)
  console.log("user: "+req.body.user+" pass: "+req.body.password+" Rtime: "+rtime);
})

// Tell our app to listen on port 5000
app.listen(PORT,() =>{
  console.log('Server started on port 5000')
})

app.use("/", router);