const mongoose = require('mongoose');

const officeSchema = new mongoose.Schema({
    office_address: {
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
    wifiAvailable: {
        type: Boolean,
        default: false
    },
    acAvailable: {
        type: Boolean,
        default: false
    },
    cabinsAvailable: {
        type: Number,
        required: true
    },
    max_capacity: {
        type: Number,
        required: true
    },
    property: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Property',
        required: true
    }
});

module.exports = mongoose.model('Office', officeSchema);
