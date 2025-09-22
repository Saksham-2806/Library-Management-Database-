-- 📚 Library Management System SQL Project

-- 1. Create Database
CREATE DATABASE LibraryDB;
USE LibraryDB;

-- 2. Create Tables
CREATE TABLE Members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100) NOT NULL,
    copies INT NOT NULL CHECK (copies >= 0)
);

CREATE TABLE Loans (
    loan_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT,
    member_id INT,
    loan_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (member_id) REFERENCES Members(member_id) ON DELETE CASCADE
);

-- 3. Insert Sample Data
INSERT INTO Members (name, email) VALUES
('Alice Johnson', 'alice@example.com'),
('Bob Smith', 'bob@example.com'),
('Charlie Brown', 'charlie@example.com');

INSERT INTO Books (title, author, copies) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', 5),
('1984', 'George Orwell', 3),
('To Kill a Mockingbird', 'Harper Lee', 4);

-- 4. Issue a Book (Example: Issue book_id=1 to member_id=2)
INSERT INTO Loans (book_id, member_id, loan_date)
VALUES (1, 2, CURDATE());

UPDATE Books SET copies = copies - 1 WHERE book_id = 1 AND copies > 0;

-- 5. Return a Book (Example: Return loan_id=1)
UPDATE Loans SET return_date = CURDATE() WHERE loan_id = 1;

UPDATE Books SET copies = copies + 1 
WHERE book_id = (SELECT book_id FROM Loans WHERE loan_id = 1);

-- 6. Useful Queries

-- View all books
SELECT * FROM Books;

-- View all members
SELECT * FROM Members;

-- View all active loans
SELECT l.loan_id, b.title, m.name, l.loan_date
FROM Loans l
JOIN Books b ON l.book_id = b.book_id
JOIN Members m ON l.member_id = m.member_id
WHERE l.return_date IS NULL;

-- View loan history
SELECT l.loan_id, b.title, m.name, l.loan_date, l.return_date
FROM Loans l
JOIN Books b ON l.book_id = b.book_id
JOIN Members m ON l.member_id = m.member_id;
