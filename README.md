# 📚 Library Management System (SQL)

A **Library Management Database Project** using SQL to manage books, members, and loans in a library efficiently.  
It includes table creation, sample data insertion, and queries for issuing and returning books.

---

## 🚀 Features
- Add and manage **books** with available copies  
- Register **library members** with unique emails  
- **Issue books** to members with loan tracking  
- **Return books** and update availability  
- View **all books, members, active loans, and loan history**  
- Fully implemented using **SQL** with relational integrity  

---

## 🛠 Database Structure
### Tables:
1. **Members** – `member_id`, `name`, `email`  
2. **Books** – `book_id`, `title`, `author`, `copies`  
3. **Loans** – `loan_id`, `book_id`, `member_id`, `loan_date`, `return_date`  

### Relationships:
- Each loan references a **book** and a **member**  
- Supports **ON DELETE CASCADE** to maintain data integrity  

---

## 📦 Setup Instructions
1. Open your **SQL console** (MySQL, MariaDB, or SQL Server).  
2. Run the script `library_management.sql` or copy the SQL code.  
3. The script will:
   - Create database `LibraryDB`  
   - Create tables: `Members`, `Books`, `Loans`  
   - Insert sample data  
   - Include example **issue** and **return** queries  

---

## ▶️ Sample Queries

- **View all books**
```sql
SELECT * FROM Books;

## View all members
SELECT * FROM Members;

## View active loans
SELECT l.loan_id, b.title, m.name, l.loan_date
FROM Loans l
JOIN Books b ON l.book_id = b.book_id
JOIN Members m ON l.member_id = m.member_id
WHERE l.return_date IS NULL;

## view loan History
SELECT l.loan_id, b.title, m.name, l.loan_date, l.return_date
FROM Loans l
JOIN Books b ON l.book_id = b.book_id
JOIN Members m ON l.member_id = m.member_id;

