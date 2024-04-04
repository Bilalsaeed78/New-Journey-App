const mongoose = require('mongoose');

const roomSchema = new mongoose.Schema({
    room_number: {
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
    max_capacity: {
        type: Number,
        required: true
    },
    wifiAvailable: {
        type: Boolean,
        default: false
    },
    contact_number: {
        type: String,
        required: true
    },
    officeSchemalocation: {
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

roomSchema.index({ location: '2dsphere' });

module.exports = mongoose.model('Room', roomSchema);