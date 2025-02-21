const pool = require("../../database/database");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

const login = async (req, res) => {
  const { user_id, password } = req.body;

  if (!user_id || !password) {
    return res.status(400).json({ message: "아이디와 비밀번호를 입력하세요." });
  }

  try {
    // 1️⃣ 데이터베이스에서 user_id 검색
    const result = await pool.query(
      "SELECT user_id, password_hash FROM users WHERE user_id = $1",
      [user_id]
    );

    if (result.rows.length === 0) {
      return res.status(401).json({ message: "존재하지 않는 아이디입니다." });
    }

    const user = result.rows[0];

    // 2️⃣ 비밀번호 비교
    const isMatch = await bcrypt.compare(password, user.password_hash);
    if (!isMatch) {
      return res.status(401).json({ message: "비밀번호가 틀렸습니다." });
    }

    // 3️⃣ JWT 토큰 생성
    const token = jwt.sign({ user_id: user.user_id }, process.env.JWT_SECRET, {
      expiresIn: "1h",
    });

    res.status(200).json({ message: "로그인 성공", token });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "서버 오류" });
  }
};

module.exports = { login };
