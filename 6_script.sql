SELECT s.*
FROM sales_contract s
INNER JOIN inventory i ON s.VIN = i.VIN
INNER JOIN vehicles v ON i.VIN = v.VIN
INNER JOIN dealerships d ON d.dealership_id = i.dealership_id
WHERE d.name = 'D & B Used Cars'
AND v.year BETWEEN 2020 AND 2023;