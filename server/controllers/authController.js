const User = require('../models/userModel');
const bcrypt = require('bcrypt');

exports.register = async (req, res) => {
    try {
        const { email, password, role, fullname, contact_no, cnic } = req.body;

        let user = await User.findOne({ $or: [{ email }, { cnic }] });
        if (user) {
            res.status(400);
            throw new Error("User already exists");
        }

        user = new User({
            email,
            password,
            role,
            fullname,
            contact_no,
            cnic
        });

        const salt = await bcrypt.genSalt(10);
        user.password = await bcrypt.hash(password, salt);

        await user.save();

        res.status(201).json({ success: true, message: "User registered successfully" });
    } catch (error) {
        res.status(500);
        throw new Error("Server Error");
    }
};

exports.authenticate = async (req, res) => {
    try {
        const { email, password } = req.body;

        const user = await User.findOne({ email });
        if (!user) {
            res.status(404);
            throw new Error( "Invalid credentials");
        }

        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            res.status(401);
            throw new Error( "Invalid credentials");
        }

        res.status(200).json({ success: true, message: "User authenticated successfully", user });
    } catch (error) {
        res.status(500);
        throw new Error("Server Error");
    }
};
