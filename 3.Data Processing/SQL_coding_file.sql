---Combining functions to get a clean and enhanced data set
Select
      transaction_id,
      transaction_date,
      transaction_time,
      transaction_qty,
      store_id,
      store_location,
      product_id,
      unit_price,
      product_category,
      product_type,
      product_detail,
---Adding columns to enhance the table for better insights
---New column added 1
      Dayname(transaction_date) AS Day_Name,
---New column added 2
      Monthname(transaction_date) AS Month_name,
---New column added 3
      Dayofmonth(transaction_date) AS Date_of_month,
---New column added 4
CASE
      When Dayname(transaction_date) IN ('Sun','Sat') Then 'Weekend'
      Else 'Weekday'
      End As Day_classification,
---New column added 5
CASE
      When date_format(transaction_time,'HH:mm:ss') BETWEEN '05:00:00' AND '08:59:59' THEN '01.Rush Hour'
      When date_format(transaction_time,'HH:mm:ss') BETWEEN '09:00:00' AND '11:59:59' THEN '02.Mid Morning'
      When date_format(transaction_time,'HH:mm:ss') BETWEEN '12:00:00' AND '15:59:59' THEN '03.Afternoon'
      When date_format(transaction_time,'HH:mm:ss') BETWEEN '16:00:00' AND '18:00:00' THEN '04.Rush Hour'
      Else '05.Night'
      End As Time_classification,
---New column added 6 - spend buckets
CASE
      When (transaction_qty*unit_price) <=50 THEN 'Low Spender'
       When (transaction_qty*unit_price) BETWEEN 50 AND 200 THEN 'Medium Spender'
       When (transaction_qty*unit_price) BETWEEN 201 AND 300 THEN 'High Spender'
      Else 'Big Spender'
      End As Spend_bucket,
---New column added 7 - Revenue
      unit_price*transaction_qty AS Revenue
From `workspace`.`casestudy_1`.`bright_coffee_shop_analysis`;
