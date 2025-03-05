const jwt = require('jsonwebtoken');
require('dotenv').config();

const authenticateToken = (req, res, next) => {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];

  if (!token) {
    return res.status(401).json({ 
      message: 'ไม่พบ Token การเข้าถึง' 
    });
  }

  jwt.verify(token, process.env.JWT_SECRET, (err, decoded) => {
    if (err) {
      return res.status(403).json({ 
        message: 'Token ไม่ถูกต้องหรือหมดอายุ' 
      });
    }
    
    // ตรวจสอบว่า decoded object มี id
    if (!decoded.id) {
      return res.status(400).json({
        message: 'ข้อมูลผู้ใช้ใน Token ไม่สมบูรณ์'
      });
    }
    
    req.user = { id: decoded.id };
    next();
  });
};

module.exports = authenticateToken;