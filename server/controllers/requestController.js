const RequestModel = require('../models/requestModel');

exports.getAllRequestByPropertyId = async (req, res) => {
  try {
    const requests = await RequestModel.find({ propertyId: req.params.propertyId });
    res.status(200).json(requests);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.getAllRequestByOwnerId = async (req, res) => {
  try {
    const requests = await RequestModel.find({ ownerId: req.params.ownerId });
    res.status(200).json(requests);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.getAllRequestByGuestId = async (req, res) => {
  try {
    const requests = await RequestModel.find({ guestId: req.params.guestId });
    res.status(200).json(requests);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.updateStatus = async (req, res) => {
  try {
    const request = await RequestModel.findByIdAndUpdate(req.params.requestId, { status: req.body.status }, { new: true });
    if (!request) {
      return res.status(404).json({ message: 'Request not found' });
    }
    res.status(200).json(request);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.createRequest = async (req, res) => {
  try {
    const newRequest = new RequestModel(req.body);
    const savedRequest = await newRequest.save();
    res.status(201).json(savedRequest);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
