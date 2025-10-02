USE karto;

-- User
DROP TABLE IF EXISTS karto.user;

-- Create Table
CREATE TABLE user (
  user_email        VARCHAR(255)    NOT NULL,
  username          VARCHAR(31)     NOT NULL,
  hashed_password   VARCHAR(127)    NOT NULL,
  created_datetime  DATETIME        NOT NULL    DEFAULT CURRENT_TIMESTAMP,

  PRIMARY KEY(user_email)
);

ALTER TABLE user
  ADD CONSTRAINT user_username_uk01
  UNIQUE (username)
;
