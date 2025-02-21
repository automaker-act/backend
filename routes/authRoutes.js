const express = require("express");
const { join } = require("../controllers/authControllers/join");
const { login } = require("../controllers/authControllers/login");

const router = express.Router();

// 회원가입 API 라우트
router.post("/signup", join);
// 로그인 API
router.post("/login", login);

module.exports = router;
