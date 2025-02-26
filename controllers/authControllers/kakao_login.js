const axios = require("axios");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const pool = require("../../database/database");
const { JWT_SECRET, KAKAO_CLIENT_ID, KAKAO_REDIRECT_URI } = process.env;

exports.kakaoLogin = async (req, res) => {
  try {
    const { code } = req.body;

    if (!code) {
      return res
        .status(400)
        .json({ message: "카카오 인가 코드가 필요합니다." });
    }

    // 1. 인가 코드로 액세스 토큰 요청
    const tokenResponse = await axios.post(
      "https://kauth.kakao.com/oauth/token",
      null,
      {
        params: {
          grant_type: "authorization_code",
          client_id: KAKAO_CLIENT_ID,
          redirect_uri: KAKAO_REDIRECT_URI,
          code,
        },
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
      }
    );

    const { access_token } = tokenResponse.data;

    // 2. 액세스 토큰으로 사용자 정보 가져오기
    const userResponse = await axios.get("https://kapi.kakao.com/v2/user/me", {
      headers: {
        Authorization: `Bearer ${access_token}`,
      },
    });

    const { id, kakao_account, properties } = userResponse.data;
    const email = kakao_account?.email || `${id}@kakao.com`;
    const username = properties?.nickname || "카카오 사용자";
    const phone_num = kakao_account?.phone_number || "";
    const birth_of_date = kakao_account?.birthyear
      ? `${kakao_account.birthyear}-01-01`
      : null;

    // 비밀번호가 필수이므로 랜덤 문자열을 해싱하여 저장
    const randomPassword = await bcrypt.hash(id.toString(), 10);

    // 3. 데이터베이스에서 사용자 확인
    const existingUser = await pool.query(
      "SELECT * FROM users WHERE user_id = $1",
      [id]
    );

    let user;
    if (existingUser.rows.length > 0) {
      user = existingUser.rows[0];
    } else {
      // 4. 새로운 사용자 저장
      const newUser = await pool.query(
        `INSERT INTO users (user_id, password_hash, username, email, phone_num, birth_of_date, created_at)
         VALUES ($1, $2, $3, $4, $5, $6, NOW()) RETURNING *`,
        [
          id.toString(),
          randomPassword,
          username,
          email,
          phone_num,
          birth_of_date,
        ]
      );

      user = newUser.rows[0];
    }

    // 5. JWT 토큰 생성
    const userPayload = { id: user.user_id, email: user.email };
    const jwtToken = jwt.sign(userPayload, JWT_SECRET, { expiresIn: "1h" });

    res.json({
      message: "카카오 로그인 성공",
      token: jwtToken,
      user: userPayload,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      message: "카카오 로그인 실패",
      error: error.response?.data || error.message,
    });
  }
};
