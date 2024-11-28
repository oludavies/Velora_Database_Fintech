DROP DATABASE IF EXISTS velora;
GO

CREATE DATABASE velora;
GO

USE velora;
GO


DROP TABLE IF EXISTS customers
GO

CREATE TABLE customers
	(
		id INT IDENTITY(1,1),-- Auto-incrementing integer column
		customer_id AS ('VEL' + RIGHT('0000000000' + CAST(id AS VARCHAR(15)), 10)) PERSISTED PRIMARY KEY, --auto-generated customer_id //computed Column
		account_id VARCHAR(10) NOT NULL UNIQUE, first_name VARCHAR(50), middle_name VARCHAR(50) NULL, last_name VARCHAR(50),
		bvn VARCHAR(11) UNIQUE, email VARCHAR(100) UNIQUE, Phone_number VARCHAR(15) UNIQUE, password_hash NVARCHAR(255) NOT NULL,
		dob DATE, customer_address VARCHAR(100), created_at DATETIME DEFAULT GETDATE(), updated_at DATETIME DEFAULT GETDATE()
	);
GO

INSERT INTO customers
	(account_id, first_name, middle_name, last_name, bvn, email, phone_number, password_hash, dob, customer_address)
VALUES
	('7064875784', 'Olubisi', 'Israel', 'Davies', '22180897043', 'olubidaves@gmail.com', '+2347064875784', '*********', CONVERT(DATE, '20-10-1987', 103), '25, Yakubu Gowon Crescent, Asokoro, Abuja, FCT'),
	('7064354784', 'Oladele', 'Patrick', 'Ajanaku', '22185707043', 'oludelep@gmail.com', '+2347064354784', '*********', CONVERT(DATE, '22-07-1992', 103), '52, Rabiu ajose, Surulere, Lagos'),
	('8023456780', 'Chidi', 'Emeka', 'Okonkwo', '22190123456', 'chidiokonkwo@gmail.com', '+2348023456780', '*********', CONVERT(DATE, '15-03-1985', 103), '12, Herbert Macaulay Way, Yaba, Lagos'),
	('8034567899', 'Aisha', 'Mohammed', 'Bello', '22195678901', 'aishabello@gmail.com', '+2348034567899', '*********', CONVERT(DATE, '30-11-1990', 103), '8, Ahmadu Bello Way, Kaduna'),
	('8045678903', 'Ngozi', 'Chioma', 'Okeke', '22200987654', 'ngoziokeke@gmail.com', '+2348045678903', '*********', CONVERT(DATE, '12-05-1988', 103), '45, Uwani Road, Enugu'),
	('8056789014', 'Yusuf', 'Ahmed', 'Muhammad', '22205432109', 'yusufmuhammad@gmail.com', '+2348056789014', '*********', CONVERT(DATE, '25-09-1993', 103), '17, Shehu Shagari Way, Kano'),
	('8067890125', 'Adebayo', 'Oluwaseun', 'Adeyemi', '22210876543', 'adebayoadeyemi@gmail.com', '+2348067890125', '*********', CONVERT(DATE, '08-12-1986', 103), '33, Awolowo Road, Ibadan'),
	('8078901236', 'Fatima', 'Abdullahi', 'Idris', '22215321098', 'fatimaidris@gmail.com', '+2348078901236', '*********', CONVERT(DATE, '17-06-1991', 103), '22, Shehu Musa Yar''Adua Street, Abuja'),
	('8089012347', 'Emeka', 'Chukwuma', 'Nwosu', '22220765432', 'emekanwosu@gmail.com', '+2348089012347', '*********', CONVERT(DATE, '03-02-1989', 103), '56, Aba Road, Port Harcourt'),
	('8090123458', 'Aminat', 'Folake', 'Lawal', '22225210987', 'aminatlawal@gmail.com', '+2348090123458', '*********', CONVERT(DATE, '19-08-1994', 103), '11, Ikorodu Road, Lagos'),
	('8001234569', 'Tunde', 'Oluwaseyi', 'Adebayo', '22230654321', 'tundeadebayo@gmail.com', '+2348001234569', '*********', CONVERT(DATE, '07-01-1987', 103), '44, Oba Akran Avenue, Ikeja'),
	('8012345670', 'Zainab', 'Hauwa', 'Umar', '22235109876', 'zainabumar@gmail.com', '+2348012345670', '*********', CONVERT(DATE, '28-04-1992', 103), '9, Ahmadu Bello Crescent, Jos'),
	('8023456781', 'Peter', 'Nnenna', 'Obi', '22240543210', 'peterobi@gmail.com', '+2348023456781', '*********', CONVERT(DATE, '14-10-1985', 103), '67, Maiduguri Road, Borno'),
	('8034567892', 'Blessing', 'Chiamaka', 'Eze', '22245987654', 'blessingeze@gmail.com', '+2348034567892', '*********', CONVERT(DATE, '21-07-1990', 103), '39, Owerri Road, Imo State'),
	('8045678963', 'Ibrahim', 'Aliyu', 'Sokoto', '22250432109', 'ibrahimsokoto@gmail.com', '+2348045678963', '*********', CONVERT(DATE, '05-11-1988', 103), '15, Sokoto Road, Sokoto'),
	('8056789074', 'Grace', 'Nneka', 'Nwankwo', '22255876543', 'gracenwankwo@gmail.com', '+2348056789074', '*********', CONVERT(DATE, '16-03-1993', 103), '28, Calabar Road, Cross River'),
	('8047890125', 'Mohammed', 'Kabir', 'Shehu', '22260321098', 'mohammedshehu@gmail.com', '+2348047890125', '*********', CONVERT(DATE, '09-09-1986', 103), '42, Lokoja Road, Kogi State');
GO

SELECT * FROM customers;
GO

EXEC sp_help customers;

DROP TABLE IF EXISTS accounts;
GO

CREATE TABLE accounts
	(
		account_id VARCHAR(10) PRIMARY KEY, account_type NVARCHAR(10) NOT NULL CHECK(account_type IN
		('savings', 'business', 'wallet')), balance DECIMAL(15,2) DEFAULT 0.00 NOT NULL, currency VARCHAR(10) NOT NULL,
		created_at DATETIME DEFAULT GETDATE(), updated_at DATETIME DEFAULT GETDATE(), CONSTRAINT FK_Customer FOREIGN KEY
		(account_id) REFERENCES customers(account_id) ON DELETE CASCADE
	);
GO

INSERT INTO accounts
	(account_id, account_type, balance, currency)
VALUES
	('7064875784', 'savings', 85587850.00, 'NGN'),
	('7064354784', 'business', 45623100.50, 'NGN'),
	('8023456780', 'wallet', 12345678.90, 'NGN'),
	('8034567899', 'savings', 23456789.01, 'NGN'),
	('8045678903', 'business', 67890123.45, 'NGN'),
	('8056789014', 'wallet', 34567890.12, 'NGN'),
	('8067890125', 'savings', 56789012.34, 'NGN'),
	('8078901236', 'business', 89012345.67, 'NGN'),
	('8089012347', 'wallet', 45678901.23, 'NGN'),
	('8090123458', 'savings', 78901234.56, 'NGN'),
	('8001234569', 'business', 90123456.78, 'NGN'),
	('8012345670', 'wallet', 23456789.01, 'NGN'),
	('8023456781', 'savings', 67890123.45, 'NGN'),
	('8034567892', 'business', 34567890.12, 'NGN'),
	('8045678963', 'wallet', 89012345.67, 'NGN'),
	('8056789074', 'savings', 56789012.34, 'NGN'),
	('8047890125', 'business', 45678901.23, 'NGN');
GO

SELECT * FROM accounts;
GO

EXEC sp_help accounts;


DROP TABLE IF EXISTS transactions;

CREATE TABLE transactions
	(
		transaction_id UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY, account_id VARCHAR(10) NOT NULL,
		transaction_type NVARCHAR(10) NOT NULL CHECK(transaction_type IN('debit', 'credit')), amount DECIMAL(15,2) NOT NULL,
		currency VARCHAR(10) NOT NULL, -- Currency code (e.g., "USD", "NGN") 
		transaction_date DATETIME DEFAULT GETDATE(), transaction_status NVARCHAR(10) NOT NULL
		CHECK (transaction_status IN('pending', 'completed', 'failed')),transaction_reference VARCHAR(100) NOT NULL UNIQUE DEFAULT NEWID(), --Unique reference for the transaction
		description NVARCHAR(MAX), -- Description of the transaction
		CONSTRAINT FK_Account FOREIGN KEY (account_id) REFERENCES accounts(account_id) ON DELETE CASCADE
	);
GO

INSERT INTO transactions
	(account_id, transaction_type, amount, currency, transaction_status, description)
VALUES
	('7064875784', 'credit', 350000.00, 'NGN', 'completed', 'Salary deposit'),
	('7064354784', 'debit', 75000.00, 'NGN', 'completed', 'Office supplies purchase'),
	('8001234569', 'credit', 150000.00, 'NGN', 'completed', 'Freelance payment'),
	('8012345670', 'debit', 25000.00, 'NGN', 'pending', 'Online shopping'),
	('8023456780', 'credit', 500000.00, 'NGN', 'completed', 'Business revenue'),
	('8023456781', 'debit', 10000.00, 'NGN', 'completed', 'Utility bill payment'),
	('8034567892', 'credit', 200000.00, 'NGN', 'completed', 'Investment return'),
	('8034567899', 'debit', 100000.00, 'NGN', 'pending', 'Equipment purchase'),
	('8045678903', 'credit', 50000.00, 'NGN', 'completed', 'Gift received'),
	('8045678963', 'debit', 30000.00, 'NGN', 'completed', 'Restaurant bill'),
	('8047890125', 'credit', 750000.00, 'NGN', 'completed', 'Contract payment'),
	('8056789014', 'debit', 15000.00, 'NGN', 'pending', 'Mobile recharge'),
	('8056789074', 'credit', 250000.00, 'NGN', 'completed', 'Bonus payment'),
	('8067890125', 'debit', 40000.00, 'NGN', 'completed', 'Grocery shopping'),
	('8078901236', 'credit', 175000.00, 'NGN', 'completed', 'Consultation fees'),
	('8089012347', 'debit', 60000.00, 'NGN', 'pending', 'Online course'),
	('8090123458', 'credit', 300000.00, 'NGN', 'completed', 'Rental income');
GO

SELECT * FROM transactions;
GO

EXEC sp_help transactions;


DROP TABLE IF EXISTS loans;

CREATE TABLE loans  
	(
		loan_id UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY, -- Unique loan ID
		customer_id VARCHAR(13) NOT NULL, -- Foreign key referencing customers table
		loan_amount DECIMAL(15, 2) NOT NULL, -- Loan amount
		interest_rate DECIMAL(5, 2) NOT NULL, -- Interest rate percentage
		loan_status NVARCHAR(10) NOT NULL CHECK (loan_status IN ('pending', 'approved', 'rejected')), -- Loan status
		issued_at DATETIME DEFAULT GETDATE(), -- Loan issuance date
		due_date DATETIME NOT NULL, -- Loan due date
		CONSTRAINT FK_Loans FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE -- Cascade delete
	);
GO

INSERT INTO loans
	(customer_id, loan_amount, interest_rate, loan_status, issued_at, due_date)
VALUES
	('VEL0000000001', 1000000.00, 12.5, 'approved', GETDATE(), DATEADD(YEAR, 3, GETDATE())),
	('VEL0000000002', 500000.00, 10.0, 'pending', GETDATE(), DATEADD(YEAR, 2, GETDATE())),
	('VEL0000000003', 2000000.00, 15.0, 'approved', GETDATE(), DATEADD(YEAR, 5, GETDATE())),
	('VEL0000000004', 750000.00, 11.5, 'pending', GETDATE(), DATEADD(YEAR, 3, GETDATE())),
	('VEL0000000005', 1500000.00, 13.0, 'approved', GETDATE(), DATEADD(YEAR, 4, GETDATE())),
	('VEL0000000006', 300000.00, 9.5, 'pending', GETDATE(), DATEADD(YEAR, 2, GETDATE())),
	('VEL0000000007', 1250000.00, 14.0, 'approved', GETDATE(), DATEADD(YEAR, 4, GETDATE())),
	('VEL0000000008', 600000.00, 10.5, 'pending', GETDATE(), DATEADD(YEAR, 3, GETDATE())),
	('VEL0000000009', 900000.00, 12.0, 'approved', GETDATE(), DATEADD(YEAR, 3, GETDATE())),
	('VEL0000000010', 400000.00, 9.0, 'pending', GETDATE(), DATEADD(YEAR, 2, GETDATE())),
	('VEL0000000011', 1750000.00, 15.5, 'approved', GETDATE(), DATEADD(YEAR, 5, GETDATE())),
	('VEL0000000012', 500000.00, 10.5, 'pending', GETDATE(), DATEADD(YEAR, 3, GETDATE())),
	('VEL0000000013', 1100000.00, 13.5, 'approved', GETDATE(), DATEADD(YEAR, 4, GETDATE())),
	('VEL0000000014', 650000.00, 11.0, 'pending', GETDATE(), DATEADD(YEAR, 3, GETDATE())),
	('VEL0000000015', 1300000.00, 14.5, 'approved', GETDATE(), DATEADD(YEAR, 4, GETDATE())),
	('VEL0000000016', 450000.00, 9.5, 'pending', GETDATE(), DATEADD(YEAR, 2, GETDATE())),
	('VEL0000000017', 2250000.00, 16.0, 'approved', GETDATE(), DATEADD(YEAR, 5, GETDATE()));
GO

SELECT * FROM loans;

EXEC sp_help loans;

DROP TABLE IF EXISTS investments;

CREATE TABLE investments
	(
		investment_id UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY, -- Unique investment ID
		customer_id VARCHAR(13) NOT NULL, -- Foreign key referencing users table
		investment_type NVARCHAR(50) NOT NULL, -- Type of investment
		amount DECIMAL(15, 2) NOT NULL, -- Investment amount
		return_rate DECIMAL(5, 2) NOT NULL, -- Rate of return percentage
		investment_date DATETIME DEFAULT GETDATE(), -- Date of investment
		maturity_date DATETIME NOT NULL, -- Maturity date
		CONSTRAINT FK_Investment FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
	);
GO


INSERT INTO investments
	(customer_id, investment_type, amount, return_rate, investment_date, maturity_date)
VALUES
	('VEL0000000001', 'Fixed Deposit', 500000.00, 8.5, GETDATE(), DATEADD(YEAR, 2, GETDATE())),
	('VEL0000000002', 'Mutual Fund', 750000.00, 12.0, GETDATE(), DATEADD(YEAR, 3, GETDATE())),
	('VEL0000000003', 'Stock Investment', 1000000.00, 15.5, GETDATE(), DATEADD(YEAR, 5, GETDATE())),
	('VEL0000000004', 'Real Estate Fund', 600000.00, 10.0, GETDATE(), DATEADD(YEAR, 4, GETDATE())),
	('VEL0000000005', 'Cryptocurrency', 250000.00, 20.0, GETDATE(), DATEADD(YEAR, 1, GETDATE())),
	('VEL0000000006', 'Government Bonds', 400000.00, 7.5, GETDATE(), DATEADD(YEAR, 3, GETDATE())),
	('VEL0000000007', 'Startup Investment', 1500000.00, 25.0, GETDATE(), DATEADD(YEAR, 5, GETDATE())),
	('VEL0000000008', 'Agriculture Fund', 350000.00, 9.0, GETDATE(), DATEADD(YEAR, 2, GETDATE())),
	('VEL0000000009', 'Tech Stock Portfolio', 900000.00, 18.0, GETDATE(), DATEADD(YEAR, 4, GETDATE())),
	('VEL0000000010', 'Energy Sector Investment', 450000.00, 12.5, GETDATE(), DATEADD(YEAR, 3, GETDATE())),
	('VEL0000000011', 'Healthcare Stocks', 800000.00, 16.0, GETDATE(), DATEADD(YEAR, 5, GETDATE())),
	('VEL0000000012', 'Green Energy Fund', 550000.00, 11.0, GETDATE(), DATEADD(YEAR, 4, GETDATE())),
	('VEL0000000013', 'Government Bonds', 470000.00, 7.5, GETDATE(), DATEADD(YEAR, 3, GETDATE())),
	('VEL0000000014', 'Energy Sector Investment', 870000.00, 12.5, GETDATE(), DATEADD(YEAR, 3, GETDATE())),
	('VEL0000000015', 'Fixed Deposit', 900000.00, 8.5, GETDATE(), DATEADD(YEAR, 2, GETDATE())),
	('VEL0000000016', 'Mutual Fund', 890000.00, 12.0, GETDATE(), DATEADD(YEAR, 3, GETDATE())),
	('VEL0000000017', 'Stock Investment', 1700000.00, 15.5, GETDATE(), DATEADD(YEAR, 5, GETDATE()));
	GO

SELECT * FROM investments;

EXEC sp_help investments;



DROP TABLE IF EXISTS cards;

CREATE TABLE cards
	(
		card_id UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY, -- Unique card ID
		customer_id VARCHAR(13) NOT NULL, -- Foreign key referencing users table
		card_number VARCHAR(16) UNIQUE NOT NULL, -- Card number
		card_type NVARCHAR(10) NOT NULL CHECK (card_type IN ('debit', 'credit')), -- Card type
		issued_date DATETIME DEFAULT GETDATE(), -- Card issue date
		expiration_date DATETIME NOT NULL DEFAULT DATEADD(YEAR, 4, GETDATE()), -- Card expiry date
		CONSTRAINT FK_UserCard FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
	);
GO

-- Insert values for cards table with uniform 16-digit card numbers
INSERT INTO cards (customer_id, card_number, card_type)
VALUES 
    ('VEL0000000001', '4532015112830366', 'debit'),
    ('VEL0000000002', '4916737623781419', 'credit'),
    ('VEL0000000003', '5425981461092894', 'debit'),
    ('VEL0000000004', '4929882355674000', 'credit'),
    ('VEL0000000005', '5585855238800454', 'debit'),
    ('VEL0000000006', '4556737676855000', 'credit'),
    ('VEL0000000007', '5425051568181618', 'debit'),
    ('VEL0000000008', '4916221246270277', 'credit'),
    ('VEL0000000009', '5506899392731000', 'debit'),
    ('VEL0000000010', '4716989979098000', 'credit'),
    ('VEL0000000011', '5472739292374185', 'debit'),
    ('VEL0000000012', '4485519311995000', 'credit'),
    ('VEL0000000013', '5508206622833214', 'debit'),
    ('VEL0000000014', '4916221099737171', 'credit'),
    ('VEL0000000015', '5425977777151838', 'debit'),
    ('VEL0000000016', '4929003541792000', 'credit'),
    ('VEL0000000017', '5506707171770202', 'debit');
GO

SELECT * FROM cards;

EXEC sp_help cards;


DROP TABLE IF EXISTS notifications;

CREATE TABLE notifications
	(
		notification_id UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY, -- Unique notification ID
		customer_id VARCHAR(13) NOT NULL, -- Foreign key referencing customers table
		message NVARCHAR(MAX) NOT NULL, -- Notification message
		status NVARCHAR(10) NOT NULL CHECK (status IN ('unread', 'read')), -- Notification status
		sent_at DATETIME DEFAULT GETDATE(), -- Notification sent timestamp
		CONSTRAINT FK_UserNotification FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
	);
GO

-- Insert values for notifications table
INSERT INTO notifications (customer_id, message, status)
VALUES 
    ('VEL0000000001', 'Your monthly statement is now available', 'unread'),
    ('VEL0000000002', 'Loan application under review', 'unread'),
    ('VEL0000000003', 'Investment maturity alert', 'read'),
    ('VEL0000000004', 'Transaction limit update', 'unread'),
    ('VEL0000000005', 'Cryptocurrency investment update', 'read'),
    ('VEL0000000006', 'Upcoming bill payment reminder', 'unread'),
    ('VEL0000000007', 'New investment opportunity', 'unread'),
    ('VEL0000000008', 'Account security check', 'read'),
    ('VEL0000000009', 'Reward points summary', 'unread'),
    ('VEL0000000010', 'Credit limit increase', 'unread'),
    ('VEL0000000011', 'Healthcare stock performance', 'read'),
    ('VEL0000000012', 'Green energy fund update', 'unread'),
    ('VEL0000000013', 'Government bond maturity', 'unread'),
    ('VEL0000000014', 'Energy sector investment alert', 'read'),
    ('VEL0000000015', 'Fixed deposit confirmation', 'unread'),
    ('VEL0000000016', 'Mutual fund quarterly report', 'unread'),
    ('VEL0000000017', 'Stock investment performance', 'read');
GO

SELECT * FROM notifications;

EXEC sp_help notifications;


DROP TABLE IF EXISTS audit_logs;

CREATE TABLE audit_logs
	(
		log_id UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY, -- Unique log ID
		user_id VARCHAR(13), -- Optional: Tracks user-related actions
		activity NVARCHAR(255) NOT NULL, -- Action description
		activity_date DATETIME DEFAULT GETDATE(), -- Timestamp of action
		entity NVARCHAR(50), -- Entity affected (e.g., users, accounts)
		entity_id NVARCHAR(100) -- ID of the affected entity
	);
GO

-- Insert values for audit_logs table
INSERT INTO audit_logs (user_id, activity, entity, entity_id)
VALUES 
    ('VEL0000000001', 'Login attempt', 'customers', 'VEL0000000001'),
    ('VEL0000000002', 'Loan application submitted', 'loans', 'VEL0000000002'),
    ('VEL0000000003', 'Investment created', 'investments', 'VEL0000000003'),
    ('VEL0000000004', 'Account details updated', 'customers', 'VEL0000000004'),
    ('VEL0000000005', 'Transaction processed', 'transactions', 'VEL0000000005'),
    ('VEL0000000006', 'Password reset', 'customers', 'VEL0000000006'),
    ('VEL0000000007', 'New card issued', 'cards', 'VEL0000000007'),
    ('VEL0000000008', 'Account opened', 'customers', 'VEL0000000008'),
    ('VEL0000000009', 'Loan approved', 'loans', 'VEL0000000009'),
    ('VEL0000000010', 'Investment matured', 'investments', 'VEL0000000010'),
    ('VEL0000000011', 'Transaction declined', 'transactions', 'VEL0000000011'),
    ('VEL0000000012', 'Card activated', 'cards', 'VEL0000000012'),
    ('VEL0000000013', 'Loan rejected', 'loans', 'VEL0000000013'),
    ('VEL0000000014', 'Investment created', 'investments', 'VEL0000000014'),
    ('VEL0000000015', 'Account closed', 'customers', 'VEL0000000015'),
    ('VEL0000000016', 'Transaction processed', 'transactions', 'VEL0000000016'),
    ('VEL0000000017', 'Loan disbursed', 'loans', 'VEL0000000017');
GO

SELECT * FROM audit_logs;

EXEC sp_help audit_logs;

DROP TABLE IF EXISTS admin_users;

CREATE TABLE admin_users 
	(
		admin_id UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY, -- Unique admin ID
		username NVARCHAR(50) UNIQUE NOT NULL, -- Admin username
		password_hash NVARCHAR(255) NOT NULL, -- Admin password (hashed)
		role NVARCHAR(50) NOT NULL, -- Admin role
		created_at DATETIME DEFAULT GETDATE(), -- Account creation date
		updated_at DATETIME DEFAULT GETDATE() -- Last update timestamp
	);
GO

-- Insert values for admin_users table
INSERT INTO admin_users (username, password_hash, role)
VALUES 
    ('admin_finance', 'pbkdf2_sha256$260000$XYZ123', 'Finance Manager'),
    ('admin_support', 'pbkdf2_sha256$260000$ABC456', 'Customer Support'),
    ('admin_risk', 'pbkdf2_sha256$260000$DEF789', 'Risk Management'),
    ('admin_compliance', 'pbkdf2_sha256$260000$GHI012', 'Compliance Officer'),
    ('admin_it', 'pbkdf2_sha256$260000$JKL345', 'IT Administrator'),
    ('admin_operations', 'pbkdf2_sha256$260000$MNO678', 'Operations Manager'),
    ('admin_security', 'pbkdf2_sha256$260000$PQR901', 'Security Specialist');
GO

SELECT * FROM admin_users;

EXEC sp_help admin_users;


DELETE FROM transactions;
DELETE FROM investments;
DELETE FROM loans;
DELETE FROM cards;
DELETE FROM accounts;
DELETE FROM customers;
GO