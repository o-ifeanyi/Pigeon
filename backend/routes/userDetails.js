const router = require("express").Router();
const verify = require("./verifyToken");
const User = require("../models/user");
const imageToBase64 = require("image-to-base64");

var base64;

router.get("/", verify, (req, res) => {
  if (req.user._id == null) console.log("null ID"), res.send("Not found");
  User.findById(req.user._id, (err, result) => {
    if (err) return res.send(err);
    imageToBase64(
      "C:/Users/Ankit/OneDrive/Desktop/Pigeon/backend/public/images/userimg/" +
        result.img
    ) // Path to the image
      .then((response) => {
        base64 = response;
      })
      .catch((error) => {
        console.log(error); // Logs an error if there was one
      });

    res.json({
      _id: result._id,
      img: base64,
      name: result.name,
      // phoneNo: result.phoneNo,
      isRead: result.isRead,
      time: result.time,
      noOfMsgUnRead: result.noOfMsgUnRead,
      isOnline: result.isOnline,
      isMissedCall: result.isMissedCall,
      haveStatus: result.haveStatus,
    });
    console.log(req.user._id);
  });
});

module.exports = router;
