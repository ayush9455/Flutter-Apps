const mongoose = require('mongoose');
const userSchema = mongoose.Schema({
    name: {
        required: true,
        type: String,
        trim: true,

    },
    email: {
        required: true,
        type: String,
        trim: true,
        vaidate: {
            validator: (value) => {
                const re =
                    /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re);
            },
            message: "Please Enter Valid Email ",
        }
    },
    password: {
        required: true,
        type: String,
        validate: {
            validator: (value) => {
                return value.length > 6;
            },
            message: "Weak Password",
        }
    },
    address: {
        type: String,
        default: '',
    },
    type: {
        type: String,
        default: 'user',
    }
});
const user = mongoose.model("User", userSchema);
module.exports = user;