import mongoose from 'mongoose'; // ⬅️ Changed from require()

const HotspotSchema = new mongoose.Schema({
    // A friendly name for the hotspot (e.g., "Bidholi Main Gate")
    name: {
        type: String,
        required: true,
        unique: true
    },

    // GeoJSON Point structure: used for geospatial indexing and queries
    location: {
        type: {
            type: String,
            enum: ['Point'], // Must be 'Point' for GeoJSON
            required: true,
            default: 'Point'
        },
        // Coordinates are stored as [longitude, latitude]
        coordinates: {
            type: [Number], // Array of numbers
            required: true
        }
    },

    address: String, // Optional human-readable address
});

// IMPORTANT: Create a 2dsphere index on the location field.
HotspotSchema.index({ location: '2dsphere' });

export default mongoose.model('Hotspot', HotspotSchema); // ⬅️ Changed to export default