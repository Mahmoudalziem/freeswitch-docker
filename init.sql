CREATE DATABASE IF NOT EXISTS asterisk DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE asterisk;

CREATE TABLE IF NOT EXISTS extensions_table (
    id INT AUTO_INCREMENT PRIMARY KEY,
    context VARCHAR(80),
    exten VARCHAR(80),
    priority INT,
    app VARCHAR(80),
    appdata VARCHAR(255)
);