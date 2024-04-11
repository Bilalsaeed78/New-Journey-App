const Request = require('../models/requestModel');

exports.getAllRequestsByPropertyIdAndGuestId = async (req, res) => {
  const { propertyId, guestId } = req.query;

  try {
    if (!propertyId || !guestId) {
      return res.status(400).send({ success: false, message: "Property ID and Guest ID are required." });
    }

    const request = await Request.findOne({
      propertyId: propertyId,
      guestId: guestId
    });

    if(!request){
      return res.status(404).json({ success: false, message: 'Request not found' });
    }

    return res.status(200).send({ success: true, request });
  } catch (error) {
    console.error("Failed to retrieve requests:", error);
    return res.status(500).send({ success: false, message: "Failed to retrieve requests due to an internal error." });
  }
};

exports.getAllRequestByPropertyId = async (req, res) => {
  try {
    const requests = await Request.find({ propertyId: req.params.propertyId });
    res.status(200).json({ success: true, requests });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

exports.getAllRequestByOwnerId = async (req, res) => {
  try {
    const requests = await Request.find({ ownerId: req.params.ownerId });
    res.status(200).json({ success: true, requests });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

exports.getAllRequestByGuestId = async (req, res) => {
  try {
    const requests = await Request.find({ guestId: req.params.guestId });
    res.status(200).json({ success: true, requests });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

exports.updateStatus = async (req, res) => {
  try {
    const request = await Request.findByIdAndUpdate(req.params.requestId, { status: req.body.status }, { new: true });
    if (!request) {
      return res.status(404).json({ success: false, message: 'Request not found' });
    }
    res.status(200).json({ success: true, message: "Status updated successfully.", request });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

exports.createRequest = async (req, res) => {
  try {
    const newRequest = new Request(req.body);
    const savedRequest = await newRequest.save();
    res.status(201).json({ success: true, message: "Request send successfully.", savedRequest });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};
