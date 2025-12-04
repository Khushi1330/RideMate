import RideOffer from '../models/RideOffer.js';
import { haversine } from '../utils/geo.js';

// simple candidate search + score
export async function searchRides({ origin, destination, startTime, endTime, seats, radiusM = 30000 }) {
  // Step 1: candidates near origin and time window
  const candidates = await RideOffer.find({
    seatsAvailable: { $gte: seats || 1 },
    startTime: { $gte: startTime, $lte: endTime },
    origin: {
      $near: {
        $geometry: { type: 'Point', coordinates: origin },
        $maxDistance: radiusM
      }
    }
  }).limit(200).lean();

  // Step 2: compute simple score based on how close dest is
  const scored = candidates.map(c => {
    const d1 = haversine(origin, c.origin.coordinates);
    const d2 = haversine(destination, c.destination.coordinates);
    const score = (1 / (1 + d1)) + (1 / (1 + d2)) - c.pricePerSeat * 0.001;
    return { ...c, _score: score, _d1: d1, _d2: d2 };
  }).filter(c => c._d2 <= radiusM); // destination must be close as well

  scored.sort((a,b) => b._score - a._score);
  return scored;
}
