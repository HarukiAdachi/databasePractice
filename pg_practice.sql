-- 問題1. postgresqlでpracticeデータベースを生成するSQL文を記述してください。
 CREATE DATABASE practice;
-- 問題2. postgresqlでpracticeデータベースのusersテーブルを生成するSQL文を記述してください。
CREATE TYPE sexual AS ENUM ('Man', 'Woman', 'Other');
 CREATE TABLE users (id SERIAL PRIMARY KEY,name CHAR(255) NOT NULL DEFAULT '',age INT NOT NULL DEFAULT 0,sex sexual NOT NULL DEFAULT 'Other');
 COMMENT ON COLUMN users.name IS '氏名';
 COMMENT ON COLUMN users.age IS '年齢';
COMMENT ON COLUMN users.sex IS '性別';
-- 問題3. postgresqlでpracticeデータベースのjobsテーブルを生成するSQL文を記述してください。
CREATE TABLE jobs (id SERIAL PRIMARY KEY,user_id INT NOT NULL,name CHAR(255) NOT NULL DEFAULT '会社員',CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES users(id));