const express = require('express');
const authRoutes = require('../routes/authRoutes');
const errorHandler = require('../middlewares/errorHander');

module.exports = function (app){
    app.use(express.json());
    app.use("/api/user", authRoutes);
    app.use(errorHandler);
}