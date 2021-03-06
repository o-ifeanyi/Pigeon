const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');

const UserSchema = mongoose.Schema({
    name: {
        type: String,
        required: true,
    },
    phone: {
        type: String,
        required: true,
    },
    otp: {
        type: String,
        required: false,
        select: false,
    },
    fcmToken: String,
    chatId: String,
    createdAt: {
        type: Number,
        default: Date.now
    }
});

// UserSchema.pre('save', async function(next) {
//     const hash = await bcrypt.hash(this.password, 10);
//     this.password = hash;
//     next();
// });

module.exports = mongoose.model('User', UserSchema);
