const express = require('express');
const router = express.Router();
const controller = require('../controllers/apicontroller');

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
router.post('/adminlogin', controller.adminlogin);
router.post('/validateToken', controller.validateToken);

router.post('/register', controller.register);
router.get('/getMenu', controller.getMenu);
router.get('/fetchmenu', authenticateJWT, controller.fetchmenu);
router.post('/addProduct', authenticateJWT, controller.addProduct);
router.get('/getProducts', controller.getProducts);



module.exports = router;
