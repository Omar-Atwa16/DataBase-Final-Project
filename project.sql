CREATE TABLE Customer (Customer_ID INT AUTO_INCREMENT PRIMARY KEY, Name VARCHAR(50), Phone VARCHAR(11));

CREATE TABLE Car (Car_ID INT AUTO_INCREMENT PRIMARY KEY, Customer_ID INT, Manufacture VARCHAR(50), Model VARCHAR(50), Year INT, Plate_NO VARCHAR(20), FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID));

CREATE TABLE Mechanic (Mechanic_ID INT AUTO_INCREMENT PRIMARY KEY, Name VARCHAR(50), Salary INT);

CREATE TABLE Services (Service_ID INT AUTO_INCREMENT PRIMARY KEY, Name VARCHAR(50), Price INT);

CREATE TABLE Supplies (Supply_ID INT AUTO_INCREMENT PRIMARY KEY, Name VARCHAR(50), Price INT, Stock INT);

CREATE TABLE Customer_Car (Customer_ID INT, Car_ID INT, FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID), FOREIGN KEY (Car_ID) REFERENCES Car(Car_ID));

CREATE TABLE Mechanic_Car (Mechanic_ID INT, Car_ID INT, PRIMARY KEY (Mechanic_ID, Car_ID));

CREATE TABLE Car_Service (Car_ID INT, Service_ID INT, FOREIGN KEY (Car_ID) REFERENCES Car(Car_ID), FOREIGN KEY (Service_ID) REFERENCES Services(Service_ID));

CREATE TABLE Mechanic_Service (Mechanic_ID INT, Service_ID INT, FOREIGN KEY (Mechanic_ID) REFERENCES Mechanic(Mechanic_ID), FOREIGN KEY (Service_ID) REFERENCES Services (Service_ID));

CREATE TABLE Service_Part (Service_ID INT, Supply_ID INT, FOREIGN KEY (Service_ID) REFERENCES Services(Service_ID), FOREIGN KEY (Supply_ID) REFERENCES Supplies(Supply_ID));

-- THE FOLLOWING 6 INSERTIONS MADE BY CHATGPT <3

INSERT INTO Customer (Name, Phone) VALUES
('John Doe', '01234567890'),
('Jane Smith', '09876543210'),
('Michael Brown', '01122334455'),
('Emily Davis', '01555555555'),
('Chris Wilson', '01777777777'),
('Anna Lee', '01333333333'),
('David Kim', '01444444444'),
('Laura Scott', '01666666666'),
('James White', '01888888888'),
('Sophia Young', '01999999999');


INSERT INTO Mechanic (Name, Salary) VALUES
('Alice Smith', 45000),
('Bob Johnson', 42000),
('Carol Martinez', 47000),
('David Clark', 43000),
('Eva Lewis', 46000),
('Frank Walker', 41000),
('Grace Hall', 44000),
('Henry Allen', 48000),
('Ivy Young', 45500),
('Jack King', 42500);


INSERT INTO Services (Name, Price) VALUES
('Oil Change', 79.99),
('Tire Rotation', 50.00),
('Brake Inspection', 60.00),
('Battery Replacement', 120.00),
('Engine Tune-Up', 250.00),
('Wheel Alignment', 90.00),
('Air Filter Replacement', 35.00),
('Transmission Service', 300.00),
('Coolant Flush', 85.00),
('Spark Plug Replacement', 100.00);


INSERT INTO Supplies (Name, Price, Stock) VALUES
('Oil Filter', 15.50, 100),
('Brake Pads', 75.00, 50),
('Battery', 120.00, 30),
('Spark Plug', 12.00, 200),
('Air Filter', 20.00, 80),
('Tire', 150.00, 40),
('Coolant', 25.00, 60),
('Transmission Fluid', 40.00, 70),
('Wiper Blade', 10.00, 90),
('Fuel Pump', 110.00, 20);


INSERT INTO Car (Customer_ID, Manufacture, Model, Year, Plate_NO) VALUES
(1, 'Toyota', 'Corolla', 2018, 'ABC-1234'),
(2, 'Honda', 'Civic', 2020, 'DEF-5678'),
(3, 'Ford', 'Focus', 2017, 'GHI-9012'),
(4, 'Chevrolet', 'Malibu', 2019, 'JKL-3456'),
(5, 'Nissan', 'Altima', 2016, 'MNO-7890'),
(6, 'BMW', 'X3', 2021, 'PQR-2345'),
(7, 'Audi', 'A4', 2015, 'STU-6789'),
(8, 'Mercedes', 'C300', 2022, 'VWX-0123'),
(9, 'Hyundai', 'Elantra', 2018, 'YZA-4567'),
(10, 'Kia', 'Soul', 2019, 'BCD-8901');


INSERT INTO Customer_Car (Customer_ID, Car_ID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- END OF THE 6 INSERTIONS

INSERT INTO Mechanic_Car (Mechanic_ID, Car_ID) VALUES
    (1,1),
    (1,2),
    (2,2),
    (2,3),
    (3,4),
    (4,5),
    (5,5),
    (6,6),
    (7,7),
    (8,8),
    (8,9),
    (9,10);


    INSERT INTO Car_Service (Car_ID, Service_ID) VALUES
    (1,1),
    (1,9),
    (2,4),
    (3,4),
    (4,7),
    (4,10),
    (5,5),
    (6,8),
    (6,6),
    (7,3),
    (8,10),
    (9,1),
    (10,9);


    INSERT INTO Service_Part (Service_ID, Supply_ID) VALUES
    (1,1),
    (3,2),
    (4,3),
    (7,5),
    (8,8),
    (9,7),
    (10,4);


-- QUERIES TO GET INFO


SELECT AVG(salary) AS avgSalary FROM mechanic;

SELECT car.*, customer.name AS ownerName FROM car LEFT JOIN customer ON car.customer_ID = customer.customer_ID;


SELECT car.car_ID, car.manufacture, car.model, car.year, SUM(services.price) AS servicePrice, SUM(supplies.price) AS suppliesPrice, SUM(COALESCE(services.price, 0) + COALESCE(supplies.price, 0)) AS Total
FROM car
LEFT JOIN car_service ON car.car_ID = car_service.car_ID
LEFT JOIN services ON car_service.service_ID = services.service_ID
LEFT JOIN service_part ON services.service_ID = service_part.service_ID
LEFT JOIN supplies ON service_part.supply_ID = supplies.supply_ID
GROUP BY car.car_ID;


SELECT  mechanic.mechanic_ID, mechanic.name, car.car_ID, car.manufacture, car.model, car.year
FROM car
LEFT JOIN mechanic_car ON car.car_ID = mechanic_car.car_ID
LEFT JOIN mechanic ON mechanic_car.mechanic_ID = mechanic.mechanic_ID
ORDER BY mechanic_ID ASC;