import dotenv from 'dotenv';
dotenv.config();
import app from './app.js';
import './config/db.js';

// Use port 3000 for consistency, or keep 4000 if your setup requires it.
// We will use 3000 here.
const port = process.env.PORT || 3000;

// 🚨 CRITICAL FIX: Bind to '0.0.0.0' to allow external connections (like your phone).
app.listen(port, '0.0.0.0', () => {
    // Log the access instructions for clarity
    console.log('----------------------------------------------------');
    console.log(`✅ Backend API is running on port ${port}`);
    console.log('Access internally via: http://localhost:3000');
    console.log('Access externally (Flutter phone) via:');
    console.log(`http://[YOUR.LOCAL.IP.ADDRESS]:${port}`);
    console.log('----------------------------------------------------');
});