const express = require('express');
const mongoose = require('mongoose');
const authRouter = require('./routes/auth');
const DB = "Your DB Credentials";
const PORT = 3000;
const app = express();
app.use(express.json());
app.use(authRouter);
mongoose.connect(DB).then(() => {
    console.log('connected');
}).catch(e => {
    console.log(e);
})
app.get('/', (req, res) => {
    res.send("This is Ayush !");
})
app.listen(PORT, "0.0.0.0", () => {
    console.log(`cocted ${PORT}`);
})