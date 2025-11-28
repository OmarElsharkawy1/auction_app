# Auction App

A real-time auction mechanism app for browser and iOS.

## Project Structure
- `backend/`: Node.js + Express + Socket.io server.
- `frontend/`: Flutter application (Web & iOS).

## How to Run

### Backend (Server)
The server handles authentication and real-time auction logic.
1. Open a terminal.
2. Navigate to the backend folder: `cd backend`
3. Start the server: `node server.js`
   - The server runs on `http://localhost:3000`.
   - To **stop** the server, press `Ctrl + C` in the terminal.

### Frontend (App)
1. Open a new terminal.
2. Navigate to the frontend folder: `cd frontend`
3. Run the app: `flutter run -d chrome`

## API Endpoints
- `POST /api/register`: Register a new user.
- `POST /api/login`: Login.
- Socket.io: Connects to `/` for real-time updates.
