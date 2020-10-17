const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
const mongoose = require("mongoose");
const dotenv = require("dotenv");
const User = require("./models/user");
const path = require("path"); 

//Import router
const authRoute = require("./routes/auth");
const postRoute = require("./routes/posts");
const getPostRoute = require("./routes/getImages");

const app = express();
dotenv.config();

//Route Middleware
app.use(bodyParser.urlencoded({ extended: true, limit: "50mb" }));
app.use('/static', express.static(path.join(__dirname, './public')));
app.use("/api/user", authRoute);
app.use("/api/posts", postRoute);
app.use("/api/img",getPostRoute);


// DB connection
mongoose.connect(
   process.env.MONGODB_URL,
  // "mongodb://localhost:27017/asd",
  { useNewUrlParser: true, useUnifiedTopology: true },
  (err,res) => {
    if(err) return console.log(err);
    console.log("connected to database");
  }
);

app.use(express.json());

app.get("/",(req,res)=>{
  res.send("started");
})

app.get("/getImage", (req, res) => {
  User.find((err, result) => {
    try {
      const result_f = result;
      res.send("<img src=" + result_f[1].img + "></img>");
    } catch (error) {
      console.log(error);
    }
  });
});


const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log("server is up and running " + PORT));
