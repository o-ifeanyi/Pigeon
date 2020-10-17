const router = require("express").Router();
const User = require("../models/user");


router.get("/", (req, res) => {
  User.find((err, result) => {
    try {
      const result_f = result;
      res.send("<img src=" + "/static/" + result_f[1].img + "></img>");
    } catch (error) {
      console.log(error);
    }
  });
});

module.exports = router;