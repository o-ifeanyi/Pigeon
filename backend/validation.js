const joi = require("@hapi/joi");

function registrationValidation(data) {
  const schema = joi.object({
    name: joi.string().required(),
    img: joi.string(),
    isRead: joi.bool(),
    isMissedCall: joi.bool(),
    isOnline: joi.bool(),
    haveStatus: joi.bool(),
    noOfMsgUnRead: joi.number(),
    time: joi.string(),
    OTP: joi.number(),
    phoneNo: joi.string().min(10).required(),
  });
  return schema.validate(data);
}

function loginValidation(data) {
  const schema = joi.object({
    phoneNo: joi.string().min(6).required(),
  });
  return schema.validate(data);
}

module.exports.registrationValidation = registrationValidation;
module.exports.loginValidation = loginValidation;
