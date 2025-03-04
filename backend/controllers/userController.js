const { Pool } = require('pg');
const jwt = require('jsonwebtoken');

const pool = new Pool({
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    database: process.env.DB_NAME,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD
});

exports.registerUser = async (req, res) => {
  try {
    const { username, email, password } = req.body;
    
    // เพิ่มข้อมูลในตาราง users
    const query = 'INSERT INTO users (username, email, password) VALUES ($1, $2, $3) RETURNING *';
    const values = [username, email, password];
    
    const result = await pool.query(query, values);
    
    res.status(201).json({
      message: 'User registered successfully',
      user: result.rows[0]
    });
  } catch (error) {
    console.error('Registration error:', error);
    res.status(500).json({ message: 'Registration failed', error: error.toString() });
  }
};

exports.loginUser = async (req, res) => {
  try {
    const { email, password } = req.body;
    
    // เชคข้อมูลในตาราง users
    const query = 'SELECT * FROM users WHERE email = $1 AND password = $2';
    const result = await pool.query(query, [email, password]);
    
    if (result.rows.length === 0) {
      return res.status(401).json({ message: 'อีเมลหรือรหัสผ่านไม่ถูกต้อง' });
    }

    const user = result.rows[0];

    // สร้าง Token
    const token = jwt.sign(
      { userId: user.id, email: user.email }, 
      process.env.JWT_SECRET, 
      { expiresIn: '1h' }
    );

    res.status(200).json({ 
      token, 
      userId: user.id,
      message: 'เข้าสู่ระบบสำเร็จ' 
    });
  } catch (error) {
    console.error('Login error:', error);
    res.status(500).json({ 
      message: 'เกิดข้อผิดพลาดในการเข้าสู่ระบบ', 
      error: error.toString() 
    });
  }
};

exports.checkEmail = async (req, res) => {
  try {
    const { email } = req.body;
    
    const query = 'SELECT * FROM users WHERE email = $1';
    const result = await pool.query(query, [email]);
    
    if (result.rows.length > 0) {
      return res.status(409).json({ message: 'อีเมลนี้มีอยู่ในระบบแล้ว' });
    }

    res.status(200).json({ message: 'อีเมลนี้สามารถใช้งานได้' });
  } catch (error) {
    console.error('Email check error:', error);
    res.status(500).json({ 
      message: 'เกิดข้อผิดพลาดในการตรวจสอบอีเมล', 
      error: error.toString() 
    });
  }
};