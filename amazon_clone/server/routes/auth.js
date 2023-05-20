const express = require('express');
const user = require('../models/user');
const bcryptjs = require('bcryptjs');
const authRouter = express.Router();
const emailValidator = require('deep-email-validator');
const jwt = require('jsonwebtoken');
const auth = require('../middlewares/auth');


authRouter.post('/api/signup', async (req, res) => {
    try {
        const { name, email, password } = req.body;
        const { valid, reason, validators } = await emailValidator.validate(email);

        if (!valid) return res.status(400).send({
            msg: `Please Provide A Valid Email Address ! ${validators[reason].reason}`,
        });


        const existingUser = await user.findOne({ email });
        if (existingUser) {
            return res.status(400).json({
                msg: "Email Already Exists",
            });
        }

        const hashpsw = await bcryptjs.hash(password, 8);
        let newUser = new user({
            name, email, password: hashpsw,
        })

        newUser = await newUser.save();
        res.json({ newUser, message: "User Created Succesfully" });
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

authRouter.post('/api/signin', async (req, res) => {
    try {
        const { email, password } = req.body;
        const { valid, reason, validators } = await emailValidator.validate(email);

        if (!valid) return res.status(400).send({
            msg: `Please Provide A Valid Email Address ! ${validators[reason].reason}`,
        });


        const existingUser = await user.findOne({ email });
        if (!existingUser) {
            return res.status(400).json({
                msg: "User Not Exists",
            });
        }
        const isMatch = await bcryptjs.compare(password, existingUser.password);
        if (!isMatch) {
            return res.status(400).json({
                msg: "Incorrect Password",
            });
        }
        const token = await jwt.sign({ id: existingUser.id }, 'passwordkey');
        res.json({ token, ...existingUser._doc });
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
})

authRouter.post('/api/istokenValid', async (req, res) => {
    try {
        const token = req.header('token');
        if (!token) return res.json(false);
        const verified = jwt.verify(token, 'passwordkey');
        if (!verified) return res.json(false);
        const userData = await user.findById(verified.id);
        if (!userData) return res.json(false);
        res.json(true);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
})

authRouter.get('/', auth, async (req, res) => {
    const userData = await user.findById(req.user);
    res.json({ ...userData._doc, token: req.token });
})

module.exports = authRouter;