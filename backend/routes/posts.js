const router = require("express").Router();
const verify = require("./verifyToken");
const User = require("../models/user");

router.get("/", verify, (req, res) => {
  User.findById(req.user._id, (err, result) => {
    if (err) return res.send(err);
    res.json({
      name: result.name,
    });
    console.log(req.user._id);
  });
});

module.exports = router;
