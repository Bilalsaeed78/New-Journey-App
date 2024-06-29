const User = require('../models/userModel');

exports.updateProfile = async (req, res) => {
    try {
        const { fullname, contact_no, profilePic } = req.body;
        const userId = req.params.id;

        const updatedUser = await User.findByIdAndUpdate(
            userId,
            { fullname, contact_no, profilePic },
            { new: true, runValidators: true }
        );

        if (!updatedUser) {
            return res.status(404).json({ success: false, message: 'User not found' });
        }

        res.status(200).json({ success: true, message: 'User updated successfully', user: updatedUser});
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
};

exports.updateProfilePicUrl = async (req, res) => {
    const userId = req.params.id;
    const { newUrl } = req.body;

    try {
        const updatedUser = await User.findById(userId);
        if (!updatedUser) {
            return res.status(404).json({ success: false, message: 'User not found' });
        }

        updatedUser.profilePic = newUrl;
        await updatedUser.save();

        res.status(200).json({ success: true, message: 'Profile pic updated successfully', user: updatedUser });
    } catch (error) {
        console.error(error);
        res.status(500).json({ success: false, message: 'Server error' });
    }
};
