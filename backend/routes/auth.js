const router = require("express").Router();
const schema = require("../validation");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const fs = require("fs");
const User = require("../models/user");

// router.get("/getImage", (req, res) => {
//   User.find((err, result) => {
//     try {
//       const result_f = result;
//       res.send("<img src=" + result_f[1].img + "></img>");
//     } catch (error) {
//       console.log(error);
//     }
//   });
// });

router.post("/registration", async (req, res) => {
  //check for error
  const { error } = schema.registrationValidation(req.body);
  if (error) return res.status(400).send(error.details[0].message);

  // check phone in database if it exist

  try {
    const phoneExist = await User.findOne({ phoneNo: req.body.phoneNo });
    if (phoneExist) return res.status(400).send("phone already exists");
  } catch (error) {
    console.log(error);
  }

  // Hash password
  // const salt = await bcrypt.genSalt(10);
  // const hashPassword = await bcrypt.hash(req.body.password,salt);

  // save user if every thing goes well
  // Save base64 image to disk
  var name = req.body.name;
  var img = req.body.img;
  var phoneNo = req.body.phoneNo;
  const OTP = Math.floor(100000 + Math.random() * 900000);
  console.log(OTP);
  try {
    // Decoding base-64 image
    function decodeBase64Image(dataString) {
      var matches = dataString.match(/^data:([A-Za-z-+\/]+);base64,(.+)$/);
      var response = {};

      if (matches.length !== 3) {
        return new Error("Invalid input string");
      }

      response.type = matches[1];
      response.data = new Buffer.from(matches[2], "base64");

      return response;
    }

    // Regular expression for image type:
    // This regular image extracts the "jpeg" from "image/jpeg"
    var imageTypeRegularExpression = /\/(.*?)$/;

    // Generate random string
    var crypto = require("crypto");
    var seed = crypto.randomBytes(20);
    var uniqueSHA1String = crypto.createHash("sha1").update(seed).digest("hex");

    var base64Data = "data:image/jpeg;base64," + img;

    var imageBuffer = decodeBase64Image(base64Data);
    var userUploadedFeedMessagesLocation = "./public/images/userImg/";
    // "../img/upload/feed/";

    var uniqueRandomImageName =
      name.replace(/\s+/g, "_") + "_" + uniqueSHA1String;
    // This variable is actually an array which has 5 values,
    // The [1] value is the real image extension
    var imageTypeDetected = imageBuffer.type.match(imageTypeRegularExpression);

    var userUploadedImagePath =
      userUploadedFeedMessagesLocation +
      uniqueRandomImageName +
      "." +
      imageTypeDetected[1];

    // Save decoded binary image to disk
    try {
      require("fs").writeFile(
        userUploadedImagePath,
        imageBuffer.data,
        function () {
          const user = new User({
            name: name,
            img: uniqueRandomImageName + "." + imageTypeDetected[1],
            OTP: OTP,
            phoneNo: phoneNo,
          });
          user.save();
          console.log(user);
          console.log(
            "DEBUG - feed:message: Saved to disk image attached by user:",
            userUploadedImagePath
          );
        }
      );
    } catch (error) {
      console.log("ERROR:", error);
    }
  } catch (error) {
    console.log("ERROR:", error);
  }

  res.status(200).json({ body: "OK", otp: OTP });
});

//LOGIN Route

router.post("/login", async (_req, res, next) => {
  //check for error
  const { error } = schema.loginValidation(_req.body);
  if (error) return res.status(400).send(error.details[0].message);
  // check email in database if it exist
  const user = await User.findOne({ phoneNo: _req.body.phoneNo });
  if (!user) return res.status(404).send("The phone number doesn't exist.");

  const OTP = Math.floor(100000 + Math.random() * 900000);
  console.log(OTP);
  try {
    const token = jwt.sign({ _id: user._id }, process.env.TOKEN_SECRET);
    res.status(200).header('auth-token', token).json({ body: "OK", otp: OTP, name: user.name });
    return next();
  } catch (error) { 
    console.error(error);
    try {
      res.status(500).json({ error: error });
    } catch (err) {
      console.log(err);
    }

    return next(error);
  }
});
module.exports = router;
