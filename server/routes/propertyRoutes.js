const express = require('express');
const router = express.Router();
const propertyController = require('../controllers/propertyController');
const upload = require("../configs/multer")

router.post('/', upload.array('files', 8), propertyController.createProperty);
router.get('/', propertyController.getAllProperties);
router.get('/:id', propertyController.getPropertyById);
router.put('/:id',  upload.array('files', 8), propertyController.updateProperty);
router.delete('/:id', propertyController.deleteProperty);

module.exports = router;
