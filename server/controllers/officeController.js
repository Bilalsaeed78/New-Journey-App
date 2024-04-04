const Office = require('../models/officeModel');

exports.createOffice = async (req, res) => {
    try {
        const { office_address, overview, rental_price, wifiAvailable, acAvailable, cabinsAvailable, max_capacity, property } = req.body;

        const office = new Office({
            office_address,
            overview,
            rental_price,
            wifiAvailable,
            acAvailable,
            cabinsAvailable,
            max_capacity,
            property
        });

        await office.save();

        res.status(201).json({ success: true, message: "Office created successfully", office });
    } catch (error) {
        res.status(500);
        throw new Error("Server Error");
    }
};

exports.getAllOffices = async (req, res) => {
    try {
        const offices = await Office.find();
        res.status(200).json({ success: true, count: offices.length, offices });
    } catch (error) {
        res.status(500);
        throw new Error("Server Error");
    }
};

exports.getOfficeById = async (req, res) => {
    try {
        const office = await Office.findById(req.params.id);
        if (!office) {
            res.status(404);
            throw new Error("Office not found");
        }
        res.status(200).json({ success: true, office });
    } catch (error) {
        res.status(500);
        throw new Error("Server Error");
    }
};

exports.updateOffice = async (req, res) => {
    try {
        const { office_address, overview, rental_price, wifiAvailable, acAvailable, cabinsAvailable, max_capacity } = req.body;

        let office = await Office.findById(req.params.id);
        if (!office) {
            res.status(404);
            throw new Error("Office not found");
        }

        office.office_address = office_address;
        office.overview = overview;
        office.rental_price = rental_price;
        office.wifiAvailable = wifiAvailable;
        office.acAvailable = acAvailable;
        office.cabinsAvailable = cabinsAvailable;
        office.max_capacity = max_capacity;

        await office.save();

        res.status(200).json({ success: true, message: "Office updated successfully", office });
    } catch (error) {
        res.status(500);
        throw new Error("Server Error");
    }
};

exports.deleteOffice = async (req, res) => {
    try {
        const office = await Office.findById(req.params.id);
        if (!office) {
            res.status(404);
            throw new Error("Office not found");
        }

        await office.remove();

        res.status(200).json({ success: true, message: "Office deleted successfully" });
    } catch (error) {
        res.status(500);
        throw new Error("Server Error");
    }
};