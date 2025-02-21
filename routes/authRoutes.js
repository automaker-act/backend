const express = require("express");
const { join } = require("../controllers/authControllers/join");

const router = express.Router();

// 회원가입 API 라우트
router.post("/signup", join);

module.exports = router;
