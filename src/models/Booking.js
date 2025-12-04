import mongoose from 'mongoose';

// Define a schema for location data consistency
const LocationSchema = new mongoose.Schema({
    name: { type: String, required: true },
    lat: { type: Number, required: true },
    lng: { type: Number, required: true },
}, { _id: false }); // Location objects don't need their own ID

const BookingSchema = new mongoose.Schema({
  // The user who made the request
  user: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'User',
      required: true
  },

  // Location fields
  pickupLocation: { type: LocationSchema, required: true },
  dropoffLocation: { type: LocationSchema, required: true },

  // Field for the activity page and analytics
  suggestedHotspotsShown: [String],

  // 🚨 CRITICAL FIX: Add the driver preference field
  driverPreference: {
      type: String,
      required: true,
      enum: [
          'Female Student', 'Female Faculty', 'Female Both',
          'Male Student', 'Male Faculty', 'Male Both',
          'No Preference'
      ],
      default: 'No Preference'
  },

  // Other fields
  seatsRequested: { type: Number, default: 1, min: 1 },
  status: { type: String, enum: ['REQUESTED','ASSIGNED','CONFIRMED','CANCELLED','COMPLETED'], default: 'REQUESTED' }
}, { timestamps: true });

BookingSchema.index({ user: 1, createdAt: -1 });

export default mongoose.model('Booking', BookingSchema);