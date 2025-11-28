const express = require('express');
const http = require('http');
const { Server } = require('socket.io');
const cors = require('cors');
const auth = require('./auth');
const auctionManager = require('./auctionManager');

const app = express();
const server = http.createServer(app);
const io = new Server(server, {
    cors: {
        origin: "*", // Allow all for demo/flutter
        methods: ["GET", "POST"]
    }
});

app.use(cors());
app.use(express.json());

// Auth Routes
app.post('/api/register', (req, res) => {
    const { email, password, username } = req.body;
    const result = auth.register(email, password, username);
    if (result.success) res.json(result);
    else res.status(400).json(result);
});

app.post('/api/login', (req, res) => {
    const { email, password } = req.body;
    const result = auth.login(email, password);
    if (result.success) res.json(result);
    else res.status(401).json(result);
});

// Socket.io
io.on('connection', (socket) => {
    console.log('A user connected:', socket.id);

    // Send initial state
    socket.emit('auctionUpdate', auctionManager.getAuctionState());

    socket.on('placeBid', (data) => {
        // data: { token, amount }
        const user = auth.verifyToken(data.token);
        if (!user) {
            socket.emit('error', { message: "Unauthorized" });
            return;
        }

        const result = auctionManager.placeBid(data.amount, user.username);
        if (result.success) {
            // Broadcast new state to EVERYONE
            io.emit('auctionUpdate', result.item);
        } else {
            socket.emit('error', { message: result.message });
        }
    });

    socket.on('disconnect', () => {
        console.log('User disconnected:', socket.id);
    });
});

const PORT = process.env.PORT || 3000;
server.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
