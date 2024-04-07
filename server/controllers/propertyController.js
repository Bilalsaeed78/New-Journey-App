const Property = require('../models/propertyModel');
const User = require('../models/userModel');

exports.createProperty = async (req, res) => {
    try {
        const { ownerId, propertyId, type } = req.body;

        const existingProperty = await Property.findOne({ propertyId });
        if (existingProperty) {
            return res.status(400).json({ success: false, message: 'Property ID already exists' });
        }

        const property = new Property({
            ownerId,
            propertyId,
            type
        });

        await property.save();

        const user = await User.findById(ownerId);
        if (!user) {
            return res.status(404).json({ success: false, message: 'Owner not found' });
        }
        user.properties.push(property._id);
        await user.save();

        res.status(201).json({ success: true, message: 'Property created successfully', property });
    } catch (error) {
        console.error(error.message);
        res.status(500).json({ success: false, message: 'Server Error' });
    }
};

exports.deleteProperty = async (req, res) => {
    try {
        const property = await Property.findById(req.params.id);
        if (!property) {
            return res.status(404).json({ success: false, message: 'Property not found' });
        }

        const user = await User.findOne({ properties: property._id });
        if (!user) {
            return res.status(404).json({ success: false, message: 'User not found' });
        }
        user.properties.pull(property._id);
        await user.save();

        await property.remove();
        res.status(200).json({ success: true, message: 'Property deleted successfully' });
    } catch (error) {
        console.error(error.message);
        res.status(500).json({ success: false, message: 'Server Error' });
    }
};

exports.getAllProperties = async (req, res) => {
    try {
        const properties = await Property.find();
        res.status(200).json({ success: true, count: properties.length, properties });
    } catch (error) {
        console.error(error.message);
        res.status(500).json({ success: false, message: 'Server Error' });
    }
};

exports.getPropertyById = async (req, res) => {
    try {
        const property = await Property.findById(req.params.id);
        if (!property) {
            return res.status(404).json({ success: false, message: 'Property not found' });
        }
        res.status(200).json({ success: true, property });
    } catch (error) {
        console.error(error.message);
        res.status(500).json({ success: false, message: 'Server Error' });
    }
};

exports.updateProperty = async (req, res) => {
    try {
        const { ownerId, propertyId, type } = req.body;

        let property = await Property.findById(req.params.id);
        if (!property) {
            return res.status(404).json({ success: false, message: 'Property not found' });
        }

        property.ownerId = ownerId || property.ownerId;
        property.propertyId = propertyId || property.propertyId;
        property.type = type || property.type;

        await property.save();
        res.status(200).json({ success: true, message: 'Property updated successfully', property });
    } catch (error) {
        console.error(error.message);
        res.status(500).json({ success: false, message: 'Server Error' });
    }
};
