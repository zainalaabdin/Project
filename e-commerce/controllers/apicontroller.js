const pool = require('../models/db');
const jwt = require('jsonwebtoken');

const JWT_SECRET = "main";

exports.login = async (req, res) => {
  try {
    const { email, password } = req.body;

    const query = 'SELECT * FROM users WHERE email = $1 AND password = $2';
    const result = await pool.query(query, [email, password]);

    if (result.rows && result.rows.length > 0 ) {
      const user = result.rows[0];
      const token = jwt.sign({ email: user.email }, JWT_SECRET, { expiresIn: '1h' });

      res.status(200).json({ 
        token: token, 
        name: user.name,
        message: "Login Successfully" 
      });
    } else {
      res.status(401).json({ message: "Email or Password incorrect" });
    }
  } catch (error) {
    console.error("Login error:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};

exports.adminlogin = async (req, res) => {
  try {
    const { email, password } = req.body;

    const query = 'SELECT * FROM users WHERE email = $1 AND password = $2';
    const result = await pool.query(query, [email, password]);

    if (result.rows && result.rows.length > 0 && result.rows[0].role === 0) {
      const user = result.rows[0];
      const token = jwt.sign({ email: user.email }, JWT_SECRET, { expiresIn: '1h' });

      res.status(200).json({ 
        token: token, 
        name: user.name,
        message: "Login Successfully" 
      });
    } else {
      res.status(401).json({ message: "Email or Password incorrect" });
    }
  } catch (error) {
    console.error("Login error:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};


exports.register = async (req, res) => {
  const { name, email, password } = req.body;
  try {
    await pool.query(
      "INSERT INTO users (name, email, password) VALUES ($1, $2, $3)",
      [name, email, password]
    );
    return res.status(201).json({ message: "User registered successfully" });
  } catch (err) {
    console.error("Registration error:", err);
    return res.status(500).json({ error: "Server error" });
  }
};



exports.validateToken = async (req, res) => {
  const token = req.header('Authorization')?.split(' ')[1];
  
      if (!token) {
          return res.status(403).json({ message: 'Access denied, no token provided' });
      }
  
      jwt.verify(token, JWT_SECRET, (err, decoded) => {
          if (err) {
              return res.status(401).json({ message: 'Invalid or expired token' });
          }
  
          req.user = decoded;
          return res.status(200).json({user: decoded, message: 'token is valid'});   
      });
};


exports.fetchmenu = async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM menu');
    res.json(result.rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Database error' });
  }
};

exports.getMenu = async (req, res) => {
  try {
    const query = 'SELECT * FROM dropdown_menu dm WHERE dm.parent_id IS NULL ORDER BY dm.menu_order ASC;';
    const result = await pool.query(query);

    for (let item of result.rows) {
      item.children = await populateChildern(item.id);
    }

    res.status(200).json(result.rows);
  } catch (error) {
    console.error("Error fetching menu:", error);
    res.status(500).json({ message: "Internal server error while fetching menu" });
  }
};


async function populateChildern(parentId){
  try{
  const query = 'select * from dropdown_menu dm where dm.parent_id = $1 order by dm.menu_order asc;';
  const result = await pool.query(query, [parentId]);

  for(let child of result.rows){
    child.children = await populateChildern(child.id);
  }

  return result.rows;
}catch(error){
  console.log(error);
  return[];
}
}






