-- =====================================================
-- PlatinumRx DA Assignment - Hotel Management System
-- Part A: Query Solutions
-- =====================================================

USE hotel_management;

-- =====================================================
-- QUESTION 1: For every user in the system, get the 
-- user_id and last booked room_no
-- =====================================================
-- Approach: Use a correlated subquery or JOIN with MAX date
-- to find the most recent booking for each user

-- Solution using JOIN with subquery
SELECT 
    b.user_id,
    b.room_no AS last_booked_room_no
FROM bookings b
INNER JOIN (
    SELECT user_id, MAX(booking_date) AS max_date
    FROM bookings
    GROUP BY user_id
) latest ON b.user_id = latest.user_id 
    AND b.booking_date = latest.max_date;

-- Alternative Solution using ROW_NUMBER() window function
SELECT 
    user_id,
    room_no AS last_booked_room_no
FROM (
    SELECT 
        user_id,
        room_no,
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY booking_date DESC) AS rn
    FROM bookings
) ranked
WHERE rn = 1;

-- =====================================================
-- QUESTION 2: Get booking_id and total billing amount 
-- of every booking created in November, 2021
-- =====================================================
-- Approach: Join bookings with booking_commercials and items
-- Filter for November 2021 and calculate total amount

SELECT 
    b.booking_id,
    SUM(bc.item_quantity * i.item_rate) AS total_billing_amount
FROM bookings b
INNER JOIN booking_commercials bc ON b.booking_id = bc.booking_id
INNER JOIN items i ON bc.item_id = i.item_id
WHERE b.booking_date >= '2021-11-01' 
    AND b.booking_date < '2021-12-01'
GROUP BY b.booking_id;

-- =====================================================
-- QUESTION 3: Get bill_id and bill amount of all the bills 
-- raised in October, 2021 having bill amount > 1000
-- =====================================================
-- Approach: Group by bill_id, filter by October 2021 date
-- and use HAVING clause for amount > 1000

SELECT 
    bc.bill_id,
    SUM(bc.item_quantity * i.item_rate) AS bill_amount
FROM booking_commercials bc
INNER JOIN items i ON bc.item_id = i.item_id
WHERE bc.bill_date >= '2021-10-01' 
    AND bc.bill_date < '2021-11-01'
GROUP BY bc.bill_id
HAVING SUM(bc.item_quantity * i.item_rate) > 1000;

-- =====================================================
-- QUESTION 4: Determine the most ordered and least ordered 
-- item of each month of year 2021
-- =====================================================
-- Approach: Use window functions to rank items by quantity 
-- ordered within each month

WITH monthly_item_orders AS (
    SELECT 
        DATE_FORMAT(bc.bill_date, '%Y-%m') AS order_month,
        i.item_name,
        SUM(bc.item_quantity) AS total_quantity
    FROM booking_commercials bc
    INNER JOIN items i ON bc.item_id = i.item_id
    WHERE bc.bill_date >= '2021-01-01' AND bc.bill_date < '2022-01-01'
    GROUP BY DATE_FORMAT(bc.bill_date, '%Y-%m'), i.item_id, i.item_name
),
ranked_items AS (
    SELECT 
        order_month,
        item_name,
        total_quantity,
        RANK() OVER (PARTITION BY order_month ORDER BY total_quantity DESC) AS rank_most,
        RANK() OVER (PARTITION BY order_month ORDER BY total_quantity ASC) AS rank_least
    FROM monthly_item_orders
)
SELECT 
    order_month,
    MAX(CASE WHEN rank_most = 1 THEN item_name END) AS most_ordered_item,
    MAX(CASE WHEN rank_most = 1 THEN total_quantity END) AS most_ordered_qty,
    MAX(CASE WHEN rank_least = 1 THEN item_name END) AS least_ordered_item,
    MAX(CASE WHEN rank_least = 1 THEN total_quantity END) AS least_ordered_qty
FROM ranked_items
GROUP BY order_month
ORDER BY order_month;

-- =====================================================
-- QUESTION 5: Find the customers with the second highest 
-- bill value of each month of year 2021
-- =====================================================
-- Approach: Calculate monthly bill totals per customer, 
-- then use window function to find second highest

WITH customer_monthly_bills AS (
    SELECT 
        u.user_id,
        u.name,
        DATE_FORMAT(bc.bill_date, '%Y-%m') AS bill_month,
        SUM(bc.item_quantity * i.item_rate) AS total_bill_amount
    FROM users u
    INNER JOIN bookings b ON u.user_id = b.user_id
    INNER JOIN booking_commercials bc ON b.booking_id = bc.booking_id
    INNER JOIN items i ON bc.item_id = i.item_id
    WHERE bc.bill_date >= '2021-01-01' AND bc.bill_date < '2022-01-01'
    GROUP BY u.user_id, u.name, DATE_FORMAT(bc.bill_date, '%Y-%m')
),
ranked_bills AS (
    SELECT 
        user_id,
        name,
        bill_month,
        total_bill_amount,
        DENSE_RANK() OVER (PARTITION BY bill_month ORDER BY total_bill_amount DESC) AS bill_rank
    FROM customer_monthly_bills
)
SELECT 
    bill_month,
    user_id,
    name,
    total_bill_amount AS second_highest_bill
FROM ranked_bills
WHERE bill_rank = 2
ORDER BY bill_month;
