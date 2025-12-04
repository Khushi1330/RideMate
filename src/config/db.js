// src/config/db.js
import dotenv from 'dotenv';
dotenv.config(); // ensure .env is loaded for this module

import mongoose from 'mongoose';

const uri = process.env.MONGO_URI;
if (!uri) {
  console.error('ERROR: MONGO_URI not set. Please create a .env file at the project root containing MONGO_URI.');
  console.error('Example .env contents:');
  console.error('  PORT=4000');
  console.error('  MONGO_URI=mongodb://127.0.0.1:27017/carpool');
  console.error('  JWT_SECRET=your_jwt_secret_here');
  // throw after logging so nodemon doesn't spin with ambiguous error
  throw new Error('MONGO_URI not set');
}

const connectOptions = {
  // recommended options; mongoose 6+ sets sensible defaults
  autoIndex: true,
  // useNewUrlParser / useUnifiedTopology are not required in Mongoose v6+, but harmless if present
};

mongoose.connect(uri, connectOptions)
  .then(() => console.log('MongoDB connected'))
  .catch(err => {
    console.error('MongoDB connection error:', err);
    // exit so process manager / nodemon shows failure
    process.exit(1);
  });

export default mongoose;
