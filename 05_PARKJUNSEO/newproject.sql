CREATE USER 'employee'@'%' IDENTIFIED BY 'employee'; -- 계정생성
CREATE database empdb; -- 데이터베이스 생성
show databases ;
GRANT All PRIVILEGES ON empdb.* TO 'employee'@'%';