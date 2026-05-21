-- Run in phpMyAdmin (http://localhost/phpmyadmin) or mysql CLI while XAMPP MySQL is running.

CREATE DATABASE IF NOT EXISTS webapp_lab
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE webapp_lab;

CREATE TABLE IF NOT EXISTS lab_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    num_value INT NOT NULL,
    square_value INT NOT NULL,
    parity VARCHAR(10) NOT NULL,
    color VARCHAR(32) NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
