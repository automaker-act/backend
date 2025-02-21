const pool = require("../../database/database");
const bcrypt = require("bcrypt");

const join = async (req, res) => {
  const { user_id, password, username, email, phone_num, birth_of_date } =
    req.body;

  if (!user_id || !password || !username || !email) {
    return res.status(400).json({ message: "필수 정보를 입력하세요." });
  }

  try {
    // 비밀번호 해싱
    const hashedPassword = await bcrypt.hash(password, 10);

    // 데이터 삽입
    const result = await pool.query(
      `INSERT INTO users (user_id, password_hash, username, email, phone_num, birth_of_date, created_at)
             VALUES ($1, $2, $3, $4, $5, $6, NOW()) RETURNING user_id`,
      [user_id, hashedPassword, username, email, phone_num, birth_of_date]
    );

    res
      .status(201)
      .json({ message: "회원가입 성공", user_id: result.rows[0].user_id });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "서버 오류" });
  }
};

module.exports = { join };
