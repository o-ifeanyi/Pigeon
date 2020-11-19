const { boolean } = require("@hapi/joi");
const mongoose = require("mongoose");
const userSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
    max: 255,
  },
  img: { type: String },
  phoneNo: {
    type: String,
    required: true,
    max: 1024,
    min: 6,
  },
  isRead: { type: Boolean },
  noOfMsgUnRead: { type: String },
  time: { type: String },
  isMissedCall: { type: Boolean },
  isOnline: { type: Boolean },
  haveStatus:{type:Boolean},
  OTP: {
    type: String,
    required: true,
  },
  date: {
    type: Date,
    default: Date.now,
  },
});
module.exports = mongoose.model("User", userSchema);
