const express = require('express');
const router = express.Router();
const locationFilterController = require('../controllers/locationFilterController');

router.get('/location', locationFilterController.filterPropertiesByDistance);

module.exports = router;