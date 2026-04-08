# PlatinumRx Data Analyst Assignment

## Overview

This repository contains the complete submission for the PlatinumRx Data Analyst Assignment, demonstrating proficiency in:
- **SQL** (Database design, schema creation, and complex queries)
- **Spreadsheets** (Data manipulation, VLOOKUP/INDEX-MATCH, time-based analysis)
- **Python** (Algorithmic problem solving, string manipulation)

---

## Project Structure

```
Data_Analyst_Assignment/
│
├── SQL/
│   ├── 01_Hotel_Schema_Setup.sql    # Hotel Management System - Schema & Data
│   ├── 02_Hotel_Queries.sql         # Hotel System - 5 Query Solutions
│   ├── 03_Clinic_Schema_Setup.sql   # Clinic Management System - Schema & Data
│   └── 04_Clinic_Queries.sql        # Clinic System - 5 Query Solutions
│
├── Spreadsheets/
│   └── Ticket_Analysis.xlsx         # Excel workbook with VLOOKUP & Analysis
│
├── Python/
│   ├── 01_Time_Converter.py         # Minutes to readable time converter
│   └── 02_Remove_Duplicates.py      # String duplicate remover
│
└── README.md                        # This file
```

---

## SQL Proficiency

### Part A: Hotel Management System

**Schema:**
- `users` - Customer information
- `bookings` - Room booking records
- `items` - Menu items with rates
- `booking_commercials` - Billing details

**Queries Solved:**
1. **Last Booked Room** - Find each user's most recent booking using window functions
2. **November 2021 Billing** - Calculate total billing amount for bookings in November
3. **High Value Bills** - Find bills > ₹1000 from October 2021 using HAVING clause
4. **Monthly Item Rankings** - Most/least ordered items per month using RANK()
5. **Second Highest Bill** - Customers with 2nd highest monthly bills using DENSE_RANK()

### Part B: Clinic Management System

**Schema:**
- `clinics` - Clinic locations and details
- `customer` - Patient information
- `clinic_sales` - Sales transactions
- `expenses` - Clinic expense records

**Queries Solved:**
1. **Revenue by Channel** - Total revenue grouped by sales channel (sodat, walk-in, online)
2. **Top 10 Customers** - Most valuable customers by total spending
3. **Monthly P&L** - Month-wise revenue, expenses, profit, and profitability status
4. **Most Profitable Clinic by City** - Using window functions to rank clinics
5. **Second Least Profitable by State** - Finding 2nd lowest profit per state

---

## Spreadsheet Proficiency

**File:** `Spreadsheets/Ticket_Analysis.xlsx`

### Sheets:
1. **Cover** - Overview and sheet index
2. **ticket** - Raw ticket data with creation/closure timestamps
3. **feedbacks** - Customer feedback with VLOOKUP/INDEX-MATCH to fetch ticket_created_at
4. **Analysis** - Outlet-wise same-day and same-hour closure analysis

### Key Formulas Used:
- **INDEX-MATCH**: Cross-sheet lookup to populate `ticket_created_at` from `cms_id`
  ```
  =IFERROR(INDEX(ticket!$C$3:$C$14,MATCH(B3,ticket!$F$3:$F$14,0)),"Not Found")
  ```

- **Same Day Count**: Using SUMPRODUCT with INT() comparison
  ```
  =SUMPRODUCT((ticket!$E$3:$E$14=B6)*(INT(ticket!$C$3:$C$14)=INT(ticket!$D$3:$D$14)))
  ```

- **Same Hour Count**: Extending same-day logic with HOUR() comparison
  ```
  =SUMPRODUCT((ticket!$E$3:$E$14=B6)*(INT(...)=INT(...))*(HOUR(...)=HOUR(...)))
  ```

---

## Python Proficiency

### 01_Time_Converter.py

Converts minutes to human-readable format:
```python
convert_minutes_to_readable(130)  # Returns: "2 hrs 10 minutes"
convert_minutes_to_readable(60)   # Returns: "1 hr"
convert_minutes_to_readable(45)   # Returns: "45 minutes"
```

**Features:**
- Integer division for hours calculation
- Modulo operator for remaining minutes
- Proper singular/plural formatting
- Interactive mode for user input

### 02_Remove_Duplicates.py

Removes duplicate characters from a string using a loop:
```python
remove_duplicates("hello")       # Returns: "helo"
remove_duplicates("programming") # Returns: "progamin"
remove_duplicates("aardvark")    # Returns: "ardvk"
```

**Algorithm:**
1. Initialize empty result string
2. Loop through each character
3. Check if character is NOT in result
4. If unique, append to result
5. Return result string

**Bonus:** Includes case-insensitive version that preserves first occurrence's case.

---

## How to Run

### SQL Scripts
```bash
# MySQL
mysql -u username -p < SQL/01_Hotel_Schema_Setup.sql
mysql -u username -p < SQL/02_Hotel_Queries.sql

# Or run in MySQL Workbench / any SQL IDE
```

### Python Scripts
```bash
# Time Converter
python Python/01_Time_Converter.py

# Remove Duplicates
python Python/02_Remove_Duplicates.py
```

### Excel File
Open `Spreadsheets/Ticket_Analysis.xlsx` in Microsoft Excel or Google Sheets.

---

## Technical Notes

### SQL Techniques Demonstrated:
- JOINs (INNER, LEFT)
- Window Functions (ROW_NUMBER, RANK, DENSE_RANK)
- Aggregation (SUM, COUNT, AVG)
- GROUP BY with HAVING
- CTEs (Common Table Expressions)
- Date/Time functions (DATE_FORMAT, YEAR, MONTH)

### Excel Techniques Demonstrated:
- Cross-sheet lookups (INDEX-MATCH)
- Date/time manipulation (INT, HOUR)
- Array formulas (SUMPRODUCT)
- Conditional calculations (IFERROR)
- Percentage formatting

### Python Techniques Demonstrated:
- Loop iteration
- String manipulation
- Conditional logic
- Modular arithmetic (//, %)
- Function design

---

## Assumptions & Design Decisions

1. **SQL**: Used MySQL syntax; may need slight adjustments for PostgreSQL/SQL Server
2. **Excel**: Used INDEX-MATCH instead of VLOOKUP for flexibility (lookup column not required to be first)
3. **Python**: Implemented case-sensitive duplicate removal as default; included case-insensitive as bonus
4. **Sample Data**: Created realistic sample data to demonstrate query functionality

---

## Contact

For any questions regarding this assignment submission, please refer to the code comments and inline documentation.

---

*Submitted for PlatinumRx Data Analyst Position*
