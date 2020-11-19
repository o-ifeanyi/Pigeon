const express = require("express");
const bodyParser = require("body-parser");
const http = require("http");
// const cors = require("cors");
const mongoose = require("mongoose");
const dotenv = require("dotenv");
const socketIO = require("socket.io");
const User = require("./models/user");

//Import router
const authRoute = require("./routes/auth");
const userDetailsRoute = require("./routes/userDetails");
const getPostRoute = require("./routes/getImages");

const app = express();
const server = http.createServer(app);
const io = socketIO(server);
dotenv.config();

//PORT
let PORT = process.env.PORT || 3000;

//EVENTS
//Connect and disconnect
let CONNECTION = "connection";
let DISCONNECT = "disconnect";

// message sending and receiving events
let RECEIVE_MESSAGE = "RECEIVE_MESSAGE";
let SEND_MESSAGE = "SEND_MESSAGE";
let RECEIVE_STATUS = "RECEIVE_STATUS";
let SEND_STATUS = "SEND_STATUS";

// Socket connection
io.on(CONNECTION, (socket) => {
  console.log(socket.id);
  //Get the chatID of the user and join in a room of the same chatID
  id = socket.handshake.query.id;
  socket.join(id, () => console.log(">>>>>>> socket joined to " + id));
  // socket.on(SEND_MESSAGE, (data) => {
  //   socket.to(id).emit(RECEIVE_MESSAGE, data);
  // });
  //Leave the room if user closes the socket
  socket.on(DISCONNECT, () => {
    socket.leave(id, () => console.log(">>>>>>> leaved the room " + id));
  });

  //send messages to only particular user
  socket.on(SEND_MESSAGE, (message) => {
    console.log(">>>>>> " + "receiverID " + message.receiverID + " senderID " + message.senderID + " message " + message.message);
    receiverID = message.receiverID;
    senderID = message.senderID;
    message = message.msg;

    //Send message to only that particular room
    socket.to(receiverID).emit(RECEIVE_MESSAGE, {
      message: message,
      senderID: senderID,
      receiverID: receiverID,
    }
    );
  });
  socket.on(SEND_STATUS,(status)=>{
    console.log(">>>>> " + " receiverID " + status.receiverID + " status " +  status.status);
    socket.in(status.receiverID).emit(RECEIVE_STATUS,{
      receiverID: status.receiverID,
      senderID: status.senderID,
      status: status.status,
    });
  });
});

//Route Middleware
// app.use(cors);
app.use(bodyParser.urlencoded({ extended: true, limit: "50mb" }));
app.use(express.static(__dirname + '/public/images/userImg/'));
// app.use("/static", express.static(path.join(__dirname, "./public")));
app.use("/api/user", authRoute);
app.use("/api/userDetails", userDetailsRoute);
app.use("/api/img", getPostRoute);

// DB connection
mongoose.connect(
  //process.env.MONGODB_URL,
  "mongodb://localhost:27017/asd",
  { useNewUrlParser: true, useUnifiedTopology: true },
  (err, res) => {
    if (err) return console.log(err);
    console.log("connected to database");
  }
);

app.use(express.json());

app.get("/", (req, res) => {
  res.send("Backend is started and running smoothly");
});

// app.get("/getImage", (req, res) => {
//   User.findById("5fa4edd0e43e9323f4a441ff",(err, result) => {
//     try {
//       const result_f = result;
//       res.send(result_f.img);
//       } catch (error) {
//       console.log(error);
//     }
//   });
// });

app.get("/getUser", (req, res) => {
  User.find((err, result) => {
    if (err) console.log(err);
    console.log(JSON.stringify(result));
    res.send(result);
  });
});


server.listen(PORT, () => console.log("server is up and running " + PORT));
