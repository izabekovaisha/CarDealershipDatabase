SELECT d.*
FROM dealerships d
INNER JOIN inventory i ON d.dealership_id = i.dealership_id
INNER JOIN vehicles v ON i.VIN = v.VIN
WHERE v.color = 'blue' AND v.make = 'BMW' AND v.model = 'X5';