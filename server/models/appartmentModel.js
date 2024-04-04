const mongoose = require('mongoose');

const apartmentSchema = new mongoose.Schema({
    apartment_number: {
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
    floor: {
        type: Number,
        required: true
    },
    rooms: {
        type: Number,
        required: true
    },
    max_capacity: {
        type: Number,
        required: true
    },
    liftAvailable: {
        type: Boolean,
        default: false
    },
    property: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Property',
        required: true
    }
});

module.exports = mongoose.model('Apartment', apartmentSchema);