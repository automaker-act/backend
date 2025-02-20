CREATE TABLE "ticket_alerts" (
	"alert_id"	INT		NOT NULL,
	"user_idx"	INT		NOT NULL,
	"performance_id"	INT		NOT NULL,
	"alert_time"	TIMESTAMP		NULL,
	"status"	BOOLEAN		NOT NULL
);

CREATE TABLE "managers" (
	"manager_id"	INT		NOT NULL,
	"manager_pw"	VARCHAR(255)		NOT NULL
);

CREATE TABLE "users" (
	"user_idx"	INT		NOT NULL,
	"user_id"	VARCHAR(100)		NOT NULL,
	"password_hash"	VARCHAR(255)		NOT NULL,
	"username"	VARCHAR(7)		NULL,
	"email"	VARCHAR(100)		NULL,
	"phone_num"	VARCHAR(11)		NULL,
	"created_at"	TIMESTAMP	DEFAULT CURRENT_TIMESTAMP	NULL,
	"birth_of_date"	VARCHAR(10)		NULL
);

CREATE TABLE "categories" (
	"category_id"	INT		NOT NULL,
	"category_name"	VARCHAR(50)		NOT NULL
);

CREATE TABLE "qna" (
	"qna_idx"	INT		NOT NULL,
	"user_idx"	INT		NOT NULL,
	"manager_id"	INT		NOT NULL,
	"title"	TEXT		NOT NULL,
	"content"	TEXT		NOT NULL,
	"date_of_qna"	TIMESTAMP	DEFAULT CURRENT_TIMESTAMP	NOT NULL
);

CREATE TABLE "tickets" (
	"ticket_id"	INT		NOT NULL,
	"performance_id"	INT		NOT NULL,
	"open_time"	DATE		NULL,
	"ticket_url"	TEXT		NULL,
	"total_tickets"	INT		NULL,
	"sold_tickets"	INT		NULL
);

CREATE TABLE "chatbot_logs" (
	"log_id"	INT		NOT NULL,
	"user_idx"	INT		NOT NULL,
	"query"	TEXT		NULL,
	"response"	TEXT		NULL,
	"timestamp"	TIMESTAMP		NULL
);

CREATE TABLE "performances" (
	"performance_id"	INT		NOT NULL,
	"category_id"	INT		NOT NULL,
	"title"	TEXT		NULL,
	"description"	TEXT		NULL,
	"performance_hall"	VARCHAR(100)		NULL,
	"performance_area"	VARCHAR(100)		NULL,
	"run_time"	VARCHAR(10)		NULL,
	"allowable_age"	INT		NULL,
	"performance_time"	VARCHAR(100)		NULL,
	"start_date"	DATE		NULL,
	"end_date"	DATE		NULL,
	"performance_status"	BOOLEAN		NULL,
	"ticket_price"	JSON		NULL,
	"image"	VARCHAR(100)		NULL,
	"reservation_office"	VARCHAR(100)		NULL,
	"genre"	VARCHAR(10)		NULL,
	"cast"	VARCHAR(100)		NULL,
	"manufacturer"	VARCHAR(100)		NULL
);

CREATE TABLE "interest_categories" (
	"interest_id"	INT		NOT NULL,
	"user_idx"	INT		NOT NULL,
	"category_id"	INT		NOT NULL
);

CREATE TABLE "recommendations" (
	"recommendation_id"	INT		NOT NULL,
	"user_idx"	INT		NOT NULL,
	"performance_id"	INT		NOT NULL
);

ALTER TABLE "ticket_alerts" ADD CONSTRAINT "PK_TICKET_ALERTS" PRIMARY KEY (
	"alert_id"
);

ALTER TABLE "managers" ADD CONSTRAINT "PK_MANAGERS" PRIMARY KEY (
	"manager_id"
);

ALTER TABLE "users" ADD CONSTRAINT "PK_USERS" PRIMARY KEY (
	"user_idx"
);

ALTER TABLE "categories" ADD CONSTRAINT "PK_CATEGORIES" PRIMARY KEY (
	"category_id"
);

ALTER TABLE "qna" ADD CONSTRAINT "PK_QNA" PRIMARY KEY (
	"qna_idx"
);

ALTER TABLE "tickets" ADD CONSTRAINT "PK_TICKETS" PRIMARY KEY (
	"ticket_id"
);

ALTER TABLE "chatbot_logs" ADD CONSTRAINT "PK_CHATBOT_LOGS" PRIMARY KEY (
	"log_id"
);

ALTER TABLE "performances" ADD CONSTRAINT "PK_PERFORMANCES" PRIMARY KEY (
	"performance_id"
);

ALTER TABLE "interest_categories" ADD CONSTRAINT "PK_INTEREST_CATEGORIES" PRIMARY KEY (
	"interest_id"
);

ALTER TABLE "recommendations" ADD CONSTRAINT "PK_RECOMMENDATIONS" PRIMARY KEY (
	"recommendation_id"
);

ALTER TABLE "ticket_alerts" ADD CONSTRAINT "FK_users_TO_ticket_alerts_1" FOREIGN KEY (
	"user_idx"
)
REFERENCES "users" (
	"user_idx"
);

ALTER TABLE "ticket_alerts" ADD CONSTRAINT "FK_performances_TO_ticket_alerts_1" FOREIGN KEY (
	"performance_id"
)
REFERENCES "performances" (
	"performance_id"
);

ALTER TABLE "qna" ADD CONSTRAINT "FK_users_TO_qna_1" FOREIGN KEY (
	"user_idx"
)
REFERENCES "users" (
	"user_idx"
);

ALTER TABLE "qna" ADD CONSTRAINT "FK_managers_TO_qna_1" FOREIGN KEY (
	"manager_id"
)
REFERENCES "managers" (
	"manager_id"
);

ALTER TABLE "tickets" ADD CONSTRAINT "FK_performances_TO_tickets_1" FOREIGN KEY (
	"performance_id"
)
REFERENCES "performances" (
	"performance_id"
);

ALTER TABLE "chatbot_logs" ADD CONSTRAINT "FK_users_TO_chatbot_logs_1" FOREIGN KEY (
	"user_idx"
)
REFERENCES "users" (
	"user_idx"
);

ALTER TABLE "performances" ADD CONSTRAINT "FK_categories_TO_performances_1" FOREIGN KEY (
	"category_id"
)
REFERENCES "categories" (
	"category_id"
);

ALTER TABLE "interest_categories" ADD CONSTRAINT "FK_users_TO_interest_categories_1" FOREIGN KEY (
	"user_idx"
)
REFERENCES "users" (
	"user_idx"
);

ALTER TABLE "interest_categories" ADD CONSTRAINT "FK_categories_TO_interest_categories_1" FOREIGN KEY (
	"category_id"
)
REFERENCES "categories" (
	"category_id"
);

ALTER TABLE "recommendations" ADD CONSTRAINT "FK_users_TO_recommendations_1" FOREIGN KEY (
	"user_idx"
)
REFERENCES "users" (
	"user_idx"
);

ALTER TABLE "recommendations" ADD CONSTRAINT "FK_performances_TO_recommendations_1" FOREIGN KEY (
	"performance_id"
)
REFERENCES "performances" (
	"performance_id"
);

