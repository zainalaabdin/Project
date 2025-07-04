const express = require('express');
const router = express.Router();
const controller = require('../controllers/apicontroller');
const multer = require("multer");
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, "uploads/"); 
  },
  filename: function (req, file, cb) {
    cb(null, Date.now() + "-" + file.originalname);
  }
});
const upload = multer({ storage: storage });

const jwt = require('jsonwebtoken');

const JWT_SECRET = "main";
function authenticateJWT(req, res, next) {
    const token = req.header('Authorization')?.split(' ')[1];

    if (!token) {
        return res.status(403).json({ message: 'Access denied, no token provided' });
    }

    jwt.verify(token, JWT_SECRET, (err, decoded) => {
        if (err) {
            return res.status(401).json({ message: 'Invalid or expired token' });
        }

        req.user = decoded;
        next();
    });
}

router.post('/login', controller.login);
router.post('/validateToken', controller.validateToken);

router.get('/fetchFaculty', controller.fetchFaculty);
router.post('/addfac', authenticateJWT, controller.addfac);
router.put('/updatefaculty', authenticateJWT, controller.updatefaculty);
router.delete('/deletefaculty/:id', authenticateJWT, controller.deletefaculty);

router.get('/departments', controller.departments);
router.post('/addDepartment', authenticateJWT, controller.addDepartment);
router.put('/updateDepartment', authenticateJWT, controller.updateDepartment);
router.delete('/deleteDepartment/:id', authenticateJWT, controller.deleteDepartment);

router.post('/addBatch', authenticateJWT, controller.addBatch);
router.get('/fetchbatch', controller.fetchbatch);
router.delete("/deletebatch/:id", authenticateJWT, controller.deletebatch);
router.put('/updateBatch', authenticateJWT, controller.updateBatch);

router.post('/addstudent', upload.single("image"), authenticateJWT, controller.addstudent);
router.get('/fetchstudent', controller.fetchstudent);
router.delete("/deletestudent/:id", authenticateJWT, controller.deletestudent);
router.put('/updatestudent', authenticateJWT, controller.updatestudent);



module.exports = router;
