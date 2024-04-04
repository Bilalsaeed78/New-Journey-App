const Room = require('../models/roomModel');

exports.createRoom = async (req, res) => {
    try {
        const { room_number, overview, rental_price, max_capacity, wifiAvailable, property_id } = req.body;

        const room = new Room({
            room_number,
            overview,
            rental_price,
            max_capacity,
            wifiAvailable,
            property_id
        });

        await room.save();

        res.status(201).json({ success: true, message: "Room created successfully", room });
    } catch (error) {
        res.status(500);
        throw new Error("Server Error");
    }
};

exports.getAllRooms = async (req, res) => {
    try {
        const rooms = await Room.find();
        res.status(200).json({ success: true, count: rooms.length, rooms });
    } catch (error) {
        res.status(500);
        throw new Error("Server Error");
    }
};

exports.getRoomById = async (req, res) => {
    try {
        const room = await Room.findById(req.params.id);
        if (!room) {
            res.status(404);
            throw new Error("Room not found");
        }
        res.status(200).json({ success: true, room });
    } catch (error) {
        res.status(500);
        throw new Error("Server Error");
    }
};

exports.updateRoom = async (req, res) => {
    try {
        const { room_number, overview, rental_price, max_capacity, wifiAvailable } = req.body;

        let room = await Room.findById(req.params.id);
        if (!room) {
            res.status(404);
            throw new Error("Room not found");
        }

        room.room_number = room_number;
        room.overview = overview;
        room.rental_price = rental_price;
        room.max_capacity = max_capacity;
        room.wifiAvailable = wifiAvailable;

        await room.save();

        res.status(200).json({ success: true, message: "Room updated successfully", room });
    } catch (error) {
        res.status(500);
        throw new Error("Server Error");
    }
};

exports.deleteRoom = async (req, res) => {
    try {
        const room = await Room.findById(req.params.id);
        if (!room) {
            res.status(404);
            throw new Error("Room not found");
        }

        await room.remove();

        res.status(200).json({ success: true, message: "Room deleted successfully" });
    } catch (error) {
        res.status(500);
        throw new Error("Server Error");
    }
};
