const jwt = require('jsonwebtoken');

const SECRET_KEY = "super_secret_key_for_demo_only"; // In prod, use env var
const users = []; // In-memory user store: { email, password, username }

function register(email, password, username) {
    if (users.find(u => u.email === email)) {
        return { success: false, message: "User already exists" };
    }
    const newUser = { email, password, username }; // In prod, hash password!
    users.push(newUser);
    return { success: true, user: { email, username } };
}

function login(email, password) {
    const user = users.find(u => u.email === email && u.password === password);
    if (!user) {
        return { success: false, message: "Invalid credentials" };
    }
    
    const token = jwt.sign({ email: user.email, username: user.username }, SECRET_KEY, { expiresIn: '1h' });
    return { success: true, token, user: { email: user.email, username: user.username } };
}

function verifyToken(token) {
    try {
        return jwt.verify(token, SECRET_KEY);
    } catch (e) {
        return null;
    }
}

module.exports = { register, login, verifyToken };
