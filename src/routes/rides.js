import express from 'express';
import mongoose from 'mongoose';

// ⚠️ Ensure your models directory contains the correct ESM format for these files
import Booking from '../models/Booking.js';

const router = express.Router();

/**
 * @route POST /rides/book
 * @desc Creates and saves a new ride booking request to MongoDB.
 * @access Protected (Requires authentication/user ID)
 */
router.post('/book', async (req, res) => {
    try {
        const { userId, origin, destination, suggestedHotspotsShown, driverPreference } = req.body;

        // Basic Validation (You should add more robust validation here)
        if (!origin || !destination || !driverPreference) {
             return res.status(400).json({ message: 'Missing required booking fields.' });
        }

        // ⚠️ Use the authenticated user ID here if using middleware.
        const userIdentifier = req.body.userId || new mongoose.Types.ObjectId('60c72b1f9b3e1c0015f8a0a1');

        const newBooking = new Booking({
            user: userIdentifier,
            pickupLocation: origin, // Flutter sends {name, lat, lng} which matches LocationSchema
            dropoffLocation: destination, // Flutter sends {name, lat, lng} which matches LocationSchema
            suggestedHotspotsShown: suggestedHotspotsShown || [],
            driverPreference: driverPreference,
            status: 'REQUESTED',
        });

        const savedBooking = await newBooking.save();

        res.status(201).json({
            message: 'Ride request saved successfully.',
            bookingId: savedBooking._id
        });

    } catch (error) {
        console.error('Booking save error:', error);
        res.status(500).json({ message: 'Failed to create booking.', error: error.message });
    }
});

export default router;