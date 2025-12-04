// src/models/User.js
import mongoose from 'mongoose';

const GeoPointSchema = new mongoose.Schema({
  type: {
    type: String,
    enum: ['Point'],
    default: 'Point'
  },
  coordinates: {
    type: [Number], // [lng, lat]
    validate: {
      validator: arr => Array.isArray(arr) && arr.length === 2,
      message: 'Coordinates must be an array of two numbers [lng, lat].'
    }
  }
}, { _id: false }); // embedded subdoc, no separate _id

const UserSchema = new mongoose.Schema({
  name: { type: String, required: true },
  email: { type: String, required: true, unique: true, index: true },
  passwordHash: { type: String, required: true },
  role: { type: String, enum: ['rider', 'driver'], default: 'rider' },
  phone: { type: String },
  rating: { type: Number, default: 5.0 },
  vehicle: {
    model: String,
    plate: String,
    seats: { type: Number, default: 4 }
  },
  // last known location for drivers (optional)
  lastLocation: {
    type: GeoPointSchema,
    required: false
  },
  status: { type: String, enum: ['online','offline','on_trip'], default: 'offline' }
}, { timestamps: true });

// ensure a 2dsphere index on lastLocation.coordinates (index on the parent path)
UserSchema.index({ 'lastLocation.coordinates': '2dsphere' });

export default mongoose.model('User', UserSchema);
