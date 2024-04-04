const mongoose = require('mongoose');

const roomSchema = new mongoose.Schema({
    room_number: {
        type: String,
        required: true
    },
    overview: {
        type: String
    },
    rental_price: {
        type: Number,
        required: true
    },
    max_capacity: {
        type: Number,
        required: true
    },
    wifiAvailable: {
        type: Boolean,
        default: false
    },
    property: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Property',
        required: true
    }
});

module.exports = mongoose.model('Room', roomSchema);