const axios = require("axios");
const jwt = require("jsonwebtoken");
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

    const { id, kakao_account } = userResponse.data;
    const email = kakao_account?.email || `${id}@kakao.com`;

    // 3. JWT 토큰 생성
    const userPayload = { id, email };
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
