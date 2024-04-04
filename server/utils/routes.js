const express = require('express');

const authRoutes = require('../routes/authRoutes');
const propertyRoutes = require('../routes/propertyRoutes');

const errorHandler = require('../middlewares/errorHander');


module.exports = function (app){
    app.use(express.json());
    app.use("/api/user", authRoutes);
    app.use("/api/property", propertyRoutes);
    app.use(errorHandler);
}