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
    
    const query = 'SELECT * FROM users WHERE email = $1 AND password = $2';
    const result = await pool.query(query, [email, password]);

    if (result.rows.length === 0) {
      return res.status(401).json({ 
        message: 'อีเมลหรือรหัสผ่านไม่ถูกต้อง' 
      });
    }

    const user = result.rows[0];
    
    // payload ของ token
    const token = jwt.sign(
      { id: user.id },
      process.env.JWT_SECRET,
      { expiresIn: '1h' }
    );

    res.status(200).json({ 
      token,
      user: {
        id: user.id,
        username: user.username,
        email: user.email
      }
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

exports.getUserData = async (req, res) => {
  try {
    const userId = req.user.id; // มาจาก JWT token
    
    // ตรวจสอบว่า userId มีค่าหรือไม่
    if (!userId) {
      return res.status(400).json({ 
        message: 'ไม่พบข้อมูลผู้ใช้ใน Token' 
      });
    }

    const query = 'SELECT username, email FROM users WHERE id = $1';
    const result = await pool.query(query, [userId]);
    
    if (result.rows.length === 0) {
      return res.status(404).json({ 
        message: 'ไม่พบข้อมูลผู้ใช้ในระบบ' 
      });
    }

    res.status(200).json(result.rows[0]);
  } catch (error) {
    console.error('Error fetching user data:', error);
    res.status(500).json({ 
      message: 'เกิดข้อผิดพลาดในการดึงข้อมูลผู้ใช้', 
      error: error.toString() 
    });
  }
};

exports.updateUserData = async (req, res) => {
  try {
    const userId = req.user.id; // มาจาก JWT token
    const { username, email, password } = req.body;

    // ตรวจสอบว่า userId มีค่าหรือไม่
    if (!userId) {
      return res.status(400).json({ 
        message: 'ไม่พบข้อมูลผู้ใช้ใน Token' 
      });
    }

    let query;
    let values;
    
    if (password) {
      query = `
        UPDATE users 
        SET username = $1, email = $2, password = $3
        WHERE id = $4
        RETURNING username, email
      `;
      values = [username, email, password, userId];
    } else {
      query = `
        UPDATE users 
        SET username = $1, email = $2
        WHERE id = $3
        RETURNING username, email
      `;
      values = [username, email, userId];
    }
    
    const result = await pool.query(query, values);

    if (result.rows.length === 0) {
      return res.status(404).json({ 
        message: 'ไม่พบข้อมูลผู้ใช้ในระบบ' 
      });
    }

    res.status(200).json({
      message: 'อัปเดตข้อมูลสำเร็จ',
      user: result.rows[0]
    });
  } catch (error) {
    console.error('Error updating user data:', error);
    res.status(500).json({ 
      message: 'เกิดข้อผิดพลาดในการอัปเดตข้อมูลผู้ใช้', 
      error: error.toString() 
    });
  }
};