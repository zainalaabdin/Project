const express = require('express');
const router = express.Router();
const { getHello, addStudent, deleteStudent, updateStudent } = require('../controllers/apicontroller');

router.get('/hello', getHello);
router.post('/addStudent', addStudent);
router.delete('/deleteStudent/:id', deleteStudent);
router.put('/submitUpdate/:id', updateStudent);
module.exports = router;

