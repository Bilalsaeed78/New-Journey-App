const Property = require('../models/propertyModel');

exports.createProperty = async (req, res) => {
    try {
        const { name, description, contact_number, location, owner, images } = req.body;

        const property = new Property({
            name,
            description,
            contact_number,
            location,
            owner,
            images
        });

        await property.save();

        res.status(201).json({ success: true, message: "Property created successfully", property });
    } catch (error) {
        res.status(500);
        throw new Error("Server Error");
    }
};

exports.getAllProperties = async (req, res) => {
    try {
        const properties = await Property.find();
        res.status(200).json({ success: true, count: properties.length, properties });
    } catch (error) {
        res.status(500);
        throw new Error("Server Error");
    }
};

exports.getPropertyById = async (req, res) => {
    try {
        const property = await Property.findById(req.params.id);
        if (!property) {
            res.status(404);
            throw new Error("Property not found");
        }
        res.status(200).json({ success: true, property });
    } catch (error) {
        res.status(500);
        throw new Error("Server Error");
    }
};

exports.updateProperty = async (req, res) => {
    try {
        const { name, description, contact_number, location, images } = req.body;

        let property = await Property.findById(req.params.id);
        if (!property) {
            res.status(404);
            throw new Error("Property not found");
        }

        property.name = name;
        property.description = description;
        property.contact_number = contact_number;
        property.location = location;
        property.images = images;

        await property.save();

        res.status(200).json({ success: true, message: "Property updated successfully", property });
    } catch (error) {
        res.status(500);
        throw new Error("Server Error");
    }
};

exports.deleteProperty = async (req, res) => {
    try {
        const property = await Property.findById(req.params.id);
        if (!property) {
            res.status(404);
            throw new Error("Property not found");
        }

        await property.remove();

        res.status(200).json({ success: true, message: "Property deleted successfully" });
    } catch (error) {
        res.status(500);
        throw new Error("Server Error");
    }
};
