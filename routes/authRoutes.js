const express = require("express");
const { join } = require("../controllers/authControllers/join");
const { login } = require("../controllers/authControllers/login");
const { kakaoLogin } = require("../controllers/authControllers/kakao_login");

const router = express.Router();

// 회원가입 API 라우트
router.post("/signup", join);
// 로그인 API
router.post("/signin", login);
// 카카오 로그인
router.post("/signin/kakao", kakaoLogin);

module.exports = router;
