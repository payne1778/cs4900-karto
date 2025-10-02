USE karto;

-- User
DROP TABLE IF EXISTS karto.user;

-- Create Table
CREATE TABLE user (
  user_email        VARCHAR(255)    NOT NULL                                COMMENT 'User Email',
  username          VARCHAR(31)     NOT NULL                                COMMENT 'Username',
  hashed_password   VARCHAR(127)    NOT NULL                                COMMENT 'Hashed Password',
  created_datetime  DATETIME        NOT NULL    DEFAULT CURRENT_TIMESTAMP   COMMENT 'Time of User Creation', 

  PRIMARY KEY(user_email)
);

ALTER TABLE user
  ADD CONSTRAINT user_username_uk01
  UNIQUE (username)
;
