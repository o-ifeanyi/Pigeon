const UserRepository = require('../repositories/UserRepository');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const jwtConfig = require('../config/jwt');
const hash = require('../utils/hash');

function generateJwtToken(user){
    const { _id } = user;
    return jwt.sign({
        _id,
    }, jwtConfig.secret);
}


class UserController {
    
    async create(req, res) {
        try {
            console.log("in try")
            console.log(req.body)
            const { name, phone } = req.body;
            if (!name || !phone) {
                return res.json({
                    error: true,
                    errorMessage: "Invalid fields.",
                })
            }
            const user = {
                name,
                phone,
                otp: "123456",
            }
            console.log(user);
            const userExists = (await UserRepository.findByUsername(user.phone)) != null;
            console.log("userExists: " + userExists)
            if (userExists) {
                return res.json({
                    error: true,
                    errorMessage: "Username already registered",
                })
            }
            await UserRepository.create(user);
            
            const newUser = await UserRepository.findByUsername(user.phone);
            const token = generateJwtToken(newUser);
            user.password = undefined;
            return res.json({
                user: newUser,
                token
            })

        } catch (err) {
            return res.json({
                error: true,
                errorMessage: "An error has occurred. Try again.",
                err
            })
        }
    }

    async login(req, res, next){
        console.log("start")
        try {
            console.log("in try")
            const { phone } = req.body;
            if (!phone) {
                return res.json({ error: true, errorMessage: "Invalid fields." })
            }
            const user = await UserRepository.findByUsername(phone);
            if (!user){
                return res.json({ error: true, errorMessage: "User not found!" });
            }
            // if (!await bcrypt.compare(password, user.password)){
            //     return res.json({ error: true, errorMessage: "username or password is invalid" });
            // }
            const token = generateJwtToken(user);
            // user.password = undefined;
            console.log("try finish")
            console.log(user)
            return res.json({
                user,
                token
            });
            
        } catch (err){
            console.log(err)
            return res.json({
                error: true,
                errorMessage: err
            })
        }
    }

    async getUsers(req, res) {
        try {
            const myId = req._id;
            const name = req.query.name;
            if (name) {
                let user = await UserRepository.getUserByName(myId, name);
                const lowerUserId = myId < user._id ? myId : user._id;
                const higherUserId = myId > user._id ? myId : user._id;
                user.chatId = hash(lowerUserId, higherUserId);
                return res.json({
                    user
                })
            }
            let users = await UserRepository.getUsersWhereNot(myId);
            users = users.map((user) => {
                const lowerUserId = myId < user._id ? myId : user._id;
                const higherUserId = myId > user._id ? myId : user._id;
                user.chatId = hash(lowerUserId, higherUserId);
                return user;
            });
            return res.json({
                users
            });
        } catch (err) {
            return res.json({
                error: true,
                errorMessage: err
            })
        }
    }

    async saveFcmToken(req, res) {
        try {
            const { fcmToken } = req.body;
            console.log("fcmToken = ", fcmToken);
            const myId = req._id;
            console.log("myId", myId);
            const myUser = await UserRepository.saveUserFcmToken(myId, fcmToken);
            return res.json({
                user: myUser
            })
        } catch (err) {
            return res.json({
                error: true,
                errorMessage: err
            })
        }
    }


}

module.exports = new UserController();