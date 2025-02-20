-- 🔹 외래 키 제약 조건 삭제
ALTER TABLE "ticket_alerts" DROP CONSTRAINT IF EXISTS "FK_users_TO_ticket_alerts_1";
ALTER TABLE "ticket_alerts" DROP CONSTRAINT IF EXISTS "FK_performances_TO_ticket_alerts_1";
ALTER TABLE "qna" DROP CONSTRAINT IF EXISTS "FK_users_TO_qna_1";
ALTER TABLE "qna" DROP CONSTRAINT IF EXISTS "FK_managers_TO_qna_1";
ALTER TABLE "tickets" DROP CONSTRAINT IF EXISTS "FK_performances_TO_tickets_1";
ALTER TABLE "chatbot_logs" DROP CONSTRAINT IF EXISTS "FK_users_TO_chatbot_logs_1";
ALTER TABLE "performances" DROP CONSTRAINT IF EXISTS "FK_categories_TO_performances_1";
ALTER TABLE "interest_categories" DROP CONSTRAINT IF EXISTS "FK_users_TO_interest_categories_1";
ALTER TABLE "interest_categories" DROP CONSTRAINT IF EXISTS "FK_categories_TO_interest_categories_1";
ALTER TABLE "recommendations" DROP CONSTRAINT IF EXISTS "FK_users_TO_recommendations_1";
ALTER TABLE "recommendations" DROP CONSTRAINT IF EXISTS "FK_performances_TO_recommendations_1";

-- 🔹 기본 키(Primary Key) 제약 조건 삭제
ALTER TABLE "ticket_alerts" DROP CONSTRAINT IF EXISTS "PK_TICKET_ALERTS";
ALTER TABLE "managers" DROP CONSTRAINT IF EXISTS "PK_MANAGERS";
ALTER TABLE "users" DROP CONSTRAINT IF EXISTS "PK_USERS";
ALTER TABLE "categories" DROP CONSTRAINT IF EXISTS "PK_CATEGORIES";
ALTER TABLE "qna" DROP CONSTRAINT IF EXISTS "PK_QNA";
ALTER TABLE "tickets" DROP CONSTRAINT IF EXISTS "PK_TICKETS";
ALTER TABLE "chatbot_logs" DROP CONSTRAINT IF EXISTS "PK_CHATBOT_LOGS";
ALTER TABLE "performances" DROP CONSTRAINT IF EXISTS "PK_PERFORMANCES";
ALTER TABLE "interest_categories" DROP CONSTRAINT IF EXISTS "PK_INTEREST_CATEGORIES";
ALTER TABLE "recommendations" DROP CONSTRAINT IF EXISTS "PK_RECOMMENDATIONS";

-- 🔹 테이블 삭제
DROP TABLE IF EXISTS "ticket_alerts";
DROP TABLE IF EXISTS "managers";
DROP TABLE IF EXISTS "users";
DROP TABLE IF EXISTS "categories";
DROP TABLE IF EXISTS "qna";
DROP TABLE IF EXISTS "tickets";
DROP TABLE IF EXISTS "chatbot_logs";
DROP TABLE IF EXISTS "performances";
DROP TABLE IF EXISTS "interest_categories";
DROP TABLE IF EXISTS "recommendations";
