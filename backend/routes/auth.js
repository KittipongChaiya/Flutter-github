const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');
const authenticateToken = require('../authMiddleware');

router.post('/register', userController.registerUser);
router.post('/login', userController.loginUser);
router.post('/check-email', userController.checkEmail);
const { getUserData } = require('../controllers/userController');
router.get('/user', authenticateToken, getUserData);
const { updateUserData } = require('../controllers/userController');
router.put('/user', authenticateToken, updateUserData);

module.exports = router;