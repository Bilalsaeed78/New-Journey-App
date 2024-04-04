const express = require('express');
const router = express.Router();
const apartmentController = require('../controllers/apartmentController');
const uploadToCloudinary = require('../middlewares/uploadFiles');

router.post('/', uploadToCloudinary, apartmentController.createApartment);
router.get('/', apartmentController.getAllApartments);
router.get('/:id', apartmentController.getApartmentById);
router.put('/:id', uploadToCloudinary, apartmentController.updateApartment);
router.delete('/:id', apartmentController.deleteApartment);

module.exports = router;
