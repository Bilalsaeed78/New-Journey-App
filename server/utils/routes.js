const express = require('express');

const authRoutes = require('../routes/authRoutes');
const officeRoutes = require('../routes/officeRoutes');
const apartmentRoutes = require('../routes/apartmentRoutes');
const roomRoutes = require('../routes/roomRoutes');


module.exports = function (app){
    app.use(express.json());
    app.use("/api/user", authRoutes);
    app.use("/api/office", officeRoutes);
    app.use("/api/apartment", apartmentRoutes);
    app.use("/api/room", roomRoutes);
}