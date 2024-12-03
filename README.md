# Velora_Database_Fintech
 Database design for a fictitious fintech company named Velora

# Overview of Key Entities

Users (Customer data)
Accounts (Bank account or wallet data)
Transactions (Records of financial activities)
Loans (Loan management)
Investments (Investment opportunities and statuses)
Cards (Debit/Credit card information)
Notifications (User notifications and alerts)
Audit Logs (Activity tracking for compliance)
Admin Users (System administrators)

# Relationships
Users ↔ Accounts: One-to-Many (A user can have multiple accounts)
Accounts ↔ Transactions: One-to-Many (An account can have multiple transactions)
Users ↔ Loans: One-to-Many (A user can apply for multiple loans)
Users ↔ Investments: One-to-Many (A user can make multiple investments)
Users ↔ Cards: One-to-Many (A user can have multiple cards)

# Database Tables

1. Users

Table Name: users
|| Fields:
user_id (Primary Key, UUID)
first_name (VARCHAR, 50)
last_name (VARCHAR, 50)
email (VARCHAR, 100, Unique)
phone_number (VARCHAR, 15, Unique)
password_hash (VARCHAR, 255)
dob (DATE)
created_at (TIMESTAMP)
updated_at (TIMESTAMP)

// Relationships: Linked to accounts, loans, investments, and cards.

2. Accounts

Table Name: accounts
|| Fields:
account_id (Primary Key, UUID)
user_id (Foreign Key → users.user_id)
account_type (ENUM: ["savings", "checking", "wallet"])
balance (DECIMAL(15, 2))
currency (VARCHAR, 10)
created_at (TIMESTAMP)
updated_at (TIMESTAMP)

// Relationships: Linked to transactions.

3. Transactions

Table Name: transactions
|| Fields:
transaction_id (Primary Key, UUID)
account_id (Foreign Key → accounts.account_id)
transaction_type (ENUM: ["debit", "credit"])
amount (DECIMAL(15, 2))
currency (VARCHAR, 10)
transaction_date (TIMESTAMP)
status (ENUM: ["pending", "completed", "failed"])
reference (VARCHAR, 100, Unique)
description (TEXT)

// Relationships: Linked to accounts.

4. Loans

Table Name: loans
|| Fields:
loan_id (Primary Key, UUID)
user_id (Foreign Key → users.user_id)
amount (DECIMAL(15, 2))
interest_rate (DECIMAL(5, 2))
term_in_months (INT)
start_date (DATE)
end_date (DATE)
status (ENUM: ["approved", "rejected", "pending", "active", "closed"])

// Relationships: Linked to users.

5. Investments

Table Name: investments
|| Fields:
investment_id (Primary Key, UUID)
user_id (Foreign Key → users.user_id)
investment_type (ENUM: ["stocks", "bonds", "mutual_funds"])
amount (DECIMAL(15, 2))
return_rate (DECIMAL(5, 2))
start_date (DATE)
end_date (DATE)
status (ENUM: ["active", "matured", "closed"])

// Relationships: Linked to users.

6. Cards

Table Name: cards
|| Fields:
card_id (Primary Key, UUID)
user_id (Foreign Key → users.user_id)
card_type (ENUM: ["debit", "credit"])
card_number (VARCHAR, 16, Unique)
expiry_date (DATE)
cvv (CHAR, 3)
status (ENUM: ["active", "blocked", "expired"])

// Relationships: Linked to users.

7. Notifications

Table Name: notifications
|| Fields:
notification_id (Primary Key, UUID)
user_id (Foreign Key → users.user_id)
message (TEXT)
status (ENUM: ["unread", "read"])
created_at (TIMESTAMP)

// Relationships: Linked to users.

8. Audit Logs

Table Name: audit_logs
|| Fields:
log_id (Primary Key, UUID)
user_id (Foreign Key → users.user_id)
action (VARCHAR, 255)
timestamp (TIMESTAMP)
ip_address (VARCHAR, 45)

// Relationships: Linked to users.

9. Admin Users
Table Name: admin_users
||Fields:
admin_id (Primary Key, UUID)
email (VARCHAR, 100, Unique)
password_hash (VARCHAR, 255)
role (ENUM: ["super_admin", "finance_admin", "compliance_admin"])
created_at (TIMESTAMP)

//Relationships: Separate entity for system management.

# Diagram Notes
The relationships can be visualized as follows for the Entity Relationship (ER) diagram:

a. users is the core table connecting to all other tables.
b. Foreign keys maintain referential integrity.
c. Audit logs track every interaction in the system for security purposes.
