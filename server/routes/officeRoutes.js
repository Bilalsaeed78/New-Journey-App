const express = require('express');
const router = express.Router();
const officeController = require('../controllers/officeController');
const uploadToCloudinary = require('../middlewares/uploadFiles');

router.post('/', uploadToCloudinary, officeController.createOffice);
router.get('/', officeController.getAllOffices);
router.get('/:id', officeController.getOfficeById);
router.put('/:id', uploadToCloudinary, officeController.updateOffice);
router.delete('/:id', officeController.deleteOffice);

module.exports = router;