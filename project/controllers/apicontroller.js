const pool = require('../db');

exports.getHello = async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM student order by id asc');
    res.json(result.rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Database error' });
  }
};

exports.addStudent = async (req, res) => {
  try {
    const { name, gender, date_of_birth, student_class, remarks } = req.body;

    console.log("Received Data:", req.body);

    const query = `
      INSERT INTO student (name, gender, date_of_birth, student_class, remarks)
      VALUES ($1, $2, $3, $4, $5)
    `;

    await pool.query(query, [name, gender, date_of_birth, student_class, remarks]);

    res.status(201).json({ message: "Student added successfully" });
  } catch (error) {
    console.error("Database Insert Error:", error);
    res.status(500).json({ error: "Database insert error" });
  }
};

exports.deleteStudent = async (req, res) => {
  try {
    const id = req.params.id;
    const result = await pool.query('DELETE FROM student WHERE id = $1', [id]);

    if (result.rowCount === 0) {
      return res.status(404).json({ message: 'Student not found' });
    }

    res.status(200).json({ message: 'Student deleted successfully' });
  } catch (error) {
    console.error("Database Delete Error:", error);
    res.status(500).json({ error: 'Database delete error' });
  }
};


exports.updateStudent = async (req, res) => {
  try {
    const studentId = req.params.id;
    const { name, gender, date_of_birth, student_class, remarks } = req.body;

    const query = `
      UPDATE student SET name = $1, gender = $2, date_of_birth = $3, student_class = $4, remarks = $5 WHERE id = $6
    `;
    await pool.query(query, [name, gender, date_of_birth, student_class, remarks, studentId]);

    res.status(200).json({ message: "Student updated successfully" });
  } catch (error) {
    console.error("Database Update Error:", error);
    res.status(500).json({ error: "Failed to update student" });
  }
};


