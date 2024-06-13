-- Find all vehicles for a specific dealership:
SELECT d.name AS dealership_name, v.*
FROM dealerships d
INNER JOIN inventory i ON d.dealership_id = i.dealership_id
INNER JOIN vehicles v ON i.VIN = v.VIN
WHERE d.name = 'D & B Used Cars';