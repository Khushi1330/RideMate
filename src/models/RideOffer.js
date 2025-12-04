// src/models/RideOffer.js
import mongoose from 'mongoose';

const GeoPointSchema = new mongoose.Schema({
  type: {
    type: String,
    enum: ['Point'],
    default: 'Point'
  },
  coordinates: {
    type: [Number], // [lng, lat]
    required: true,
    validate: {
      validator: arr => Array.isArray(arr) && arr.length === 2,
      message: 'Coordinates must be an array of two numbers [lng, lat].'
    }
  }
}, { _id: false });

const RideOfferSchema = new mongoose.Schema({
  driverId: { type: mongoose.Types.ObjectId, ref: 'User', required: true },
  origin: { type: GeoPointSchema, required: true },
  originAddress: { type: String },
  destination: { type: GeoPointSchema, required: true },
  destinationAddress: { type: String },
  waypoints: { type: [GeoPointSchema], default: [] },
  startTime: { type: Date, required: true },
  seatsAvailable: { type: Number, required: true, min: 0 },
  pricePerSeat: { type: Number, required: true, min: 0 },
  routePolyline: { type: String } // optional encoded polyline
}, { timestamps: true });

// Indexes for geo queries
RideOfferSchema.index({ 'origin.coordinates': '2dsphere' });
RideOfferSchema.index({ 'destination.coordinates': '2dsphere' });
RideOfferSchema.index({ startTime: 1 });

export default mongoose.model('RideOffer', RideOfferSchema);
