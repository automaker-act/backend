const database = require("../../database/database");

// -------------- 모든 유저 정보 불러오기 --------------
exports.getUsers = async (req, res) => {
  const query = `SELECT * FROM users`
  try {
    const result = await database.query(query);
    return res.status(200).json(result.rows);
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
};