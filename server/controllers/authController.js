const User = require('../models/userModel');
const bcrypt = require('bcrypt');

exports.register = async (req, res) => {
    try {
        const { email, password, role, fullname, contact_no, cnic } = req.body;

        let user = await User.findOne({ $or: [{ email }, { cnic }] });
        if (user) {
            return res.status(400).json({ success: false, message: "User already exists" });
        }

        user = new User({
            email,
            password,
            role: role.toLowerCase(),
            fullname,
            contact_no,
            cnic
        });
        const salt = await bcrypt.genSalt(10);
        user.password = await bcrypt.hash(password, salt);

        await user.save();

        res.status(201).json({ success: true, message: "User registered successfully" });
    } catch (error) {
        console.log(error);
        return res.status(500).json({ success: false, message: "Server Error" });
    }
};

exports.authenticate = async (req, res) => {
    try {
        const { email, password } = req.body;

        const user = await User.findOne({ email });
        if (!user) {
            return res.status(400).json({ success: false, message: "Invalid credentials" });
        }

        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            return res.status(401).json({ success: false, message: "Invalid credentials" });
        }

        res.status(201).json({ success: true, message: "User authenticated successfully", user });
    } catch (error) {
        return res.status(500).json({ success: false, message: "Server Error" });
    }
};
