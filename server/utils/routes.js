const express = require('express');

const authRoutes = require('../routes/authRoutes');
const propertyRoutes = require('../routes/propertyRoutes');
const officeRoutes = require('../routes/officeRoutes');
const apartmentRoutes = require('../routes/apartmentRoutes');
const roomRoutes = require('../routes/roomRoutes');
const bookingRoutes = require('../routes/bookingRoutes');
const reviewRoutes = require('../routes/reviewRoutes');
const locationFilterRoutes = require('../routes/locationFilterRoutes');
const requestRoutes = require('../routes/requestRoutes');

module.exports = function (app){
    app.use(express.json());
    app.use("/api/user", authRoutes);
    app.use("/api/property", propertyRoutes);
    app.use("/api/office", officeRoutes);
    app.use("/api/apartment", apartmentRoutes);
    app.use("/api/room", roomRoutes);
    app.use("/api/booking", bookingRoutes);
    app.use("/api/review", reviewRoutes);
    app.use("/api/filter", locationFilterRoutes);
    app.use("/api/request", requestRoutes);
}