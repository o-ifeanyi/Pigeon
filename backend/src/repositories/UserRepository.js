const User = require('../models/UserModel');
const ObjectId = require('mongoose').Types.ObjectId;

class UserRepository {

    async create({ name, phone, otp}) {
        await User.create({
            name,
            phone,
            otp,
        });
        console.log("user created");
    }

    async findByUsername(phone) {
        return await User.findOne({ phone }).select({ 'name': 1, 'phone': 1
    
    });
    }

    async getUsersWhereNot(userId) {
        return await User.find({ _id: { $ne: ObjectId(userId) } });
    }

    async getUserByName(myId, name) {
        return await User.find({
            _id: { $ne: ObjectId(myId), name }
        });
    }

    async saveUserFcmToken(userId, fcmToken) {
        return await User.updateOne({ _id: ObjectId(userId) }, {
            fcmToken
        });
    }


}

module.exports = new UserRepository();