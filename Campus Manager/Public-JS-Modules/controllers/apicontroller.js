const pool = require('../db');
const jwt = require('jsonwebtoken');

exports.fetchFaculty = async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM faculty');
    res.json(result.rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Database error' });
  }
};


exports.addfac = async (req, res) => {
  try {
    const { faculty, remarks } = req.body;
    if (!faculty || faculty.trim() === "") {
      return res.status(400).json({ message: "Faculty can't be empty" });
    }
    await pool.query(
    'INSERT INTO faculty (name, remarks) VALUES ($1, $2)',
    [faculty.trim(), remarks?.trim() || null]
    );
    res.status(201).json({ message: "Faculty Added Successfully" });
  } catch (error) {
    console.error("Database error:", error);
    res.status(500).json({ error: "Failed to add faculty" });
  }
};





exports.updatefaculty = async (req, res) => {
  try {
    const { id, name, remarks } = req.body;
    await pool.query(
      'UPDATE faculty SET name = $1, remarks = $2 WHERE id = $3',
      [name, remarks, id]
    );
    res.status(200).json({ message: "Faculty updated successfully" });
  } catch (error) {
    console.error("Database update error:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};


exports.deletefaculty = async (req, res) => {
  try {
    const id = req.params.id;
    const result = await pool.query('DELETE FROM faculty WHERE id = $1', [id]);
    if (result.rowCount === 0) {
      return res.status(404).json({ message: 'Faculty not found' });
    }
    res.status(200).json({ message: 'Faculty deleted successfully' });
  } catch (error) {
    console.error("Database Delete Error:", error);
    res.status(500).json({ error: 'Database delete error' });
  }
};



//department code here
// for fetch data

exports.departments = async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM department');
    res.json(result.rows);
  } catch (error) {
    console.error('Error fetching departments:', error);
    res.status(500).json({ error: 'Database error' });
  }
};

exports.addDepartment = async (req, res) => {
  try {
    const { facultyId, name, code, email, phone } = req.body;
    console.log("Received data:", req.body);
    await pool.query(
      'INSERT INTO department (name, code, email, phone, faculty_id) VALUES ($1, $2, $3, $4, $5)',
      [name, code, email, phone, facultyId]
    );
    res.status(201).json({ message: "Department Added Successfully" });
  } catch (error) {
    console.log("Database error", error);  // Log full error
    res.status(500).json({ error: "Failed to add department" });
  }
};

// controllers/departmentController.js

exports.updateDepartment = async (req, res) => {
  try {
    const { id, name, code, email, phone } = req.body;
    await pool.query(
      'UPDATE department SET name = $1, code = $2, email = $3, phone = $4 WHERE id = $5',
      [name, code, email, phone, id]
    );
    res.status(200).json({ message: "Department updated successfully" });
  } catch (error) {
    console.error("Database update error:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};

exports.deleteDepartment = async (req, res) => {
  try {
    const { id } = req.params;
    await pool.query(
      'DELETE FROM department WHERE id = $1',
      [id]
    );

    res.status(200).json({ message: "Department deleted successfully" });
  } catch (error) {
    console.error("Database delete error:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};


exports.addBatch = async (req, res) => {
  try {
    const { name, startYear, endYear, remarks, departmentId } = req.body;
    console.log("Received batch data:", req.body);

    await pool.query(
      'INSERT INTO batch (name, start_year, end_year, remarks, dept_id) VALUES ($1, $2, $3, $4, $5)',
      [name, startYear, endYear, remarks, departmentId]
    );

    res.status(201).json({ message: "Batch Added Successfully" });
  } catch (error) {
    console.log("Database error:", error);
    res.status(500).json({ error: "Failed to add batch" });
  }
};

exports.fetchbatch = async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM batch');  
    console.log("Fetched batches:", result.rows);            
    res.json(result.rows);                                    
  } catch (error) {
    console.error('Database error:', error);
    res.status(500).json({ error: 'Database error' });
  }
};

exports.deletebatch = async (req, res) => {
  try {
    const { id } = req.params; 
    await pool.query(
      'DELETE FROM batch WHERE id = $1', 
      [id]
    );

    res.status(200).json({ message: "Batch deleted successfully" });
  } catch (error) {
    console.error("Database delete error:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};


exports.updateBatch = async (req, res) => {
  try {
    const { id, name, dept_id, start_year, end_year, remarks } = req.body;
    const query = `
      UPDATE batch
      SET name = $1, dept_id = $2, start_year = $3, end_year = $4, remarks = $5 WHERE id = $6 `;
    await pool.query(query, [name, dept_id, start_year, end_year, remarks, id]);
    res.status(200).json({ message: "Batch updated successfully" });
  } catch (error) {
    console.error("Batch update error:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};


exports.fetchstudent = async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM student ORDER BY id DESC');
    res.status(200).json(result.rows);
  } catch (error) {
    console.error("Error fetching students:", error);
    res.status(500).json({ error: "Failed to fetch students" });
  }
};

exports.addstudent = async (req, res) => {
  try {
    const { name, roll_num, email, phone, gender, dob, address, admission_date, remarks, batch_id } = req.body;
    const image = req.file ? req.file.filename : null;

    console.log("Received student data:", req.body);
    console.log("Image uploaded", image);

    const query = `
      INSERT INTO student ( name, roll_num, email, phone, gender, dob, address, admission_date, remarks, batch_id, image
      ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)`;

    await pool.query(query, [
      name, roll_num, email, phone, gender, dob, address, admission_date, remarks, batch_id, image ]);

    res.status(201).json({ message: "Student Added Successfully" });

  } catch (error) {
    console.error("Database error:", error);
    res.status(500).json({ error: "Failed to add student" });
  }
};



exports.deletestudent = async (req, res) => {
  try {
    const { id } = req.params; 
    await pool.query(
      'DELETE FROM student WHERE id = $1', 
      [id]
    );

    res.status(200).json({ message: "Student deleted successfully" });
  } catch (error) {
    console.error("Database delete error:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};


exports.updatestudent = async (req, res) => {
  try {
    const {
      id, name, roll_num, email, phone, gender, dob, address, admission_date, remarks, batch_id } = req.body;

     const query = `
      UPDATE student SET name = $1, roll_num = $2, email = $3, phone = $4, gender = $5, dob = $6, address = $7, admission_date = $8,
      remarks = $9, batch_id = $10 WHERE id = $11 `;

    await pool.query(query, [
    name, roll_num, email, phone, gender, dob, address, admission_date, remarks, batch_id, id ]);

    res.status(200).json({ message: "Student updated successfully" });
  } catch (error) {
    console.error("Student update error:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};

const JWT_SECRET = "main";
exports.login = async (req, res) => {
  try{
  const {
    name, password } = req.body;
    let query = `SELECT password from login WHERE user_name = $1`;
    const result =  await pool.query(query, [name]);
    if(result.rows && result.rows[0].password == password){
      const token = jwt.sign({ username: name }, "main", { expiresIn: '1h' });
        res.status(200).json({token: token, message: "Login Successfully" });
    }else{
      res.status(401).json({ message: "Username Password Wrong" });
    }
 
      }catch (error) {
    console.error("Login error:", error);
    res.status(500).json({ error: "Internal server error" });
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