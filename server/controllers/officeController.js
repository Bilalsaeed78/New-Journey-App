const Office = require('../models/officeModel');

exports.createOffice = async (req, res) => {
    try {
        const { office_address, overview, type, rental_price, wifiAvailable, acAvailable, cabinsAvailable, max_capacity, contact_number, location, owner, images } = req.body;

        if (!office_address || !type || !rental_price || !cabinsAvailable || !max_capacity || !contact_number || !location || !owner) {
            return res.status(400).json({ success: false, message: "All required fields must be provided"});
        }

        const office = new Office({
            office_address,
            overview,
            type,
            rental_price,
            wifiAvailable,
            acAvailable,
            cabinsAvailable,
            max_capacity,
            contact_number,
            location,
            owner,
            images
        });

        await office.save();

        res.status(201).json({ success: true, message: "Office created successfully", office });
    } catch (error) {
        console.error(error.message);
        res.status(500).json({ success: false, message: "Server Error" });
    }
};

exports.getAllOffices = async (req, res) => {
    try {
        const offices = await Office.find();
        res.status(200).json({ success: true, count: offices.length, offices });
    } catch (error) {
        console.error(error.message);
        res.status(500).json({ success: false, message: "Server Error" });
    }
};

exports.getOfficeById = async (req, res) => {
    try {
        const office = await Office.findById(req.params.id);
        if (!office) {
            res.status(404).json({ success: false, message: "Office not found" });
            return;
        }
        res.status(200).json({ success: true, office });
    } catch (error) {
        console.error(error.message);
        res.status(500).json({ success: false, message: "Server Error" });
    }
};

exports.updateOffice = async (req, res) => {
    try {
        const { office_address, overview, type, rental_price, wifiAvailable, acAvailable, cabinsAvailable, max_capacity, contact_number, location, owner, images } = req.body;

        let office = await Office.findById(req.params.id);
        if (!office) {
            res.status(404).json({ success: false, message: "Office not found" });
            return;
        }

        office.office_address = office_address || office.office_address;
        office.overview = overview || office.overview;
        office.type = type || office.type;
        office.rental_price = rental_price || office.rental_price;
        office.wifiAvailable = wifiAvailable || office.wifiAvailable;
        office.acAvailable = acAvailable || office.acAvailable;
        office.cabinsAvailable = cabinsAvailable || office.cabinsAvailable;
        office.max_capacity = max_capacity || office.max_capacity;
        office.contact_number = contact_number || office.contact_number;
        office.location = location || office.location;
        office.owner = owner || office.owner;
        office.images = images || office.images;

        await office.save();

        res.status(200).json({ success: true, message: "Office updated successfully", office });
    } catch (error) {
        console.error(error.message);
        res.status(500).json({ success: false, message: "Server Error" });
    }
};

exports.deleteOffice = async (req, res) => {
    try {
        const office = await Office.findById(req.params.id);
        if (!office) {
            res.status(404).json({ success: false, message: "Office not found" });
            return;
        }

        await office.remove();

        res.status(200).json({ success: true, message: "Office deleted successfully" });
    } catch (error) {
        console.error(error.message);
        res.status(500).json({ success: false, message: "Server Error" });
    }
};
