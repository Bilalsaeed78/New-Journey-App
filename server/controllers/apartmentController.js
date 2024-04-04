const Apartment = require('../models/apartmentModel');

exports.createApartment = async (req, res) => {
    try {
        const { apartment_number, overview, rental_price, floor, rooms, max_capacity, liftAvailable, property } = req.body;

        const apartment = new Apartment({
            apartment_number,
            overview,
            rental_price,
            floor,
            rooms,
            max_capacity,
            liftAvailable,
            property
        });

        await apartment.save();

        res.status(201).json({ success: true, message: "Apartment created successfully", apartment });
    } catch (error) {
        res.status(500);
        throw new Error("Server Error");
    }
};

exports.getAllApartments = async (req, res) => {
    try {
        const apartments = await Apartment.find();
        res.status(200).json({ success: true, count: apartments.length, apartments });
    } catch (error) {
        res.status(500);
        throw new Error("Server Error");
    }
};

exports.getApartmentById = async (req, res) => {
    try {
        const apartment = await Apartment.findById(req.params.id);
        if (!apartment) {
            res.status(404);
            throw new Error("Apartment not found");
        }
        res.status(200).json({ success: true, apartment });
    } catch (error) {
        res.status(500);
        throw new Error("Server Error");
    }
};

exports.updateApartment = async (req, res) => {
    try {
        const { apartment_number, overview, rental_price, floor, rooms, max_capacity, liftAvailable } = req.body;

        let apartment = await Apartment.findById(req.params.id);
        if (!apartment) {
            res.status(404);
            throw new Error("Apartment not found");
        }

        apartment.apartment_number = apartment_number;
        apartment.overview = overview;
        apartment.rental_price = rental_price;
        apartment.floor = floor;
        apartment.rooms = rooms;
        apartment.max_capacity = max_capacity;
        apartment.liftAvailable = liftAvailable;

        await apartment.save();

        res.status(200).json({ success: true, message: "Apartment updated successfully", apartment });
    } catch (error) {
        res.status(500);
        throw new Error("Server Error");
    }
};

exports.deleteApartment = async (req, res) => {
    try {
        const apartment = await Apartment.findById(req.params.id);
        if (!apartment) {
            res.status(404);
            throw new Error("Apartment not found");
        }

        await apartment.remove();

        res.status(200).json({ success: true, message: "Apartment deleted successfully" });
    } catch (error) {
        res.status(500);
        throw new Error("Server Error");
    }
};