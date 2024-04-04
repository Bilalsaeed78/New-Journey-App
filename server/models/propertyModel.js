const mongoose = require('mongoose');

const propertySchema = new mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    description: {
        type: String
    },
    contact_number: {
        type: String,
        required: true
    },
    location: {
        type: String,
        required: true
    },
    owner: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    images: {
        type: [String],
        validate: {
            validator: function(images) {
                return images.length >= 1 && images.length <= 8; 
            },
            message: props => `Number of images must be between 1 and 8`
        }
    }
});

module.exports = mongoose.model('Property', propertySchema);