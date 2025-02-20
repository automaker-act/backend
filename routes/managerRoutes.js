const router = require("express").Router(); // api path 를 전달해 주는 메서드

const { getUsers } = require("../controllers/managerControllers/managerAuth");

router.get("/users", getUsers);

module.exports = router; // router 모듈 내보내기
