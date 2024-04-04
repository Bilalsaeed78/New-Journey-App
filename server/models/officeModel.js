const mongoose = require('mongoose');

const officeSchema = new mongoose.Schema({
    office_address: {
        type: String,
        required: true
    },
    overview: {
        type: String
    },
    type: {
        type: String,
        enum: ['office', 'apartment', 'room'],
        required: true
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
    contact_number: {
        type: String,
        required: true
    },
    location: {
        type: {
            type: String,
            enum: ['Point'],
            required: true
        },
        coordinates: {
            type: [Number],
            required: true
        }
    },
    owner: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    images: {
        type: [String],
    }
});

officeSchema.index({ location: '2dsphere' });

module.exports = mongoose.model('Office', officeSchema);
