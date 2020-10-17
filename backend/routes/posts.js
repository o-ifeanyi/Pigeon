const router = require("express").Router();
const verify = require("./verifyToken");
const User = require("../models/user");

router.get("/", verify, (req, res) => {
  //   res.json({
  //     posts: {
  //       title: "my post",
  //       post: "random post data you shouldn't access."
  //     },
  //   });
  //   console.log(req.user._id);
  User.findById(req.user._id, (err, result) => {
    res.send(result);
  });
});

module.exports = router;
