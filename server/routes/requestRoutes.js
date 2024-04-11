const express = require('express');
const router = express.Router();
const {
  getAllRequestByPropertyId,
  getAllRequestByOwnerId,
  getAllRequestByGuestId,
  updateStatus,
  createRequest,
  getAllRequestsByPropertyIdAndGuestId
} = require('../controllers/requestController');

router.get('/byProperty/:propertyId', getAllRequestByPropertyId);
router.get('/checkStatus', getAllRequestsByPropertyIdAndGuestId);
router.get('/byOwner/:ownerId', getAllRequestByOwnerId);
router.get('/byGuest/:guestId', getAllRequestByGuestId);
router.put('/updateStatus/:requestId', updateStatus);
router.post('/', createRequest);

module.exports = router;
