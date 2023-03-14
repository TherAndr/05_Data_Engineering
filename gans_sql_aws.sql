USE gans;

-- create static tables
CREATE TABLE IF NOT EXISTS cities(
	city_code INT AUTO_INCREMENT, 
    city VARCHAR(50),
    country VARCHAR(50),
    latitude FLOAT(6), 
    longitude FLOAT(6), 
    population INT,
    PRIMARY KEY (city_code)
);
INSERT INTO cities(city_code, city, country, latitude, longitude, population) 
VALUES
(1, "Berlin", "Germany", 52.3112, 13.2418, 3677472),
(2, "Hamburg", "Germany", 53.3300, 10.0000, 1906411),
(3, "London", "United Kingdom", 51.3026, 0.7390, 8799800),
(4, "Manchester", "United Kingdom", 53.2846, 2.1443, 551938),
(5, "Barcelona", "Spain", 41.2300, 2.1100, 1620343);
DROP TABLE cities; 
SELECT * FROM cities;

CREATE TABLE IF NOT EXISTS airports(
	icao VARCHAR(5),
    airport_name VARCHAR(255),
    city_code INT,
    PRIMARY KEY (icao)
);
INSERT INTO airports(icao, airport_name, city_code) 
VALUES
("EDDB", "Berlin, Berlin Brandenburg", 1),
("EDDH", "Hamburg", 2),
("EGLC", "London, London City", 3),
("EGLL", "London, London Heathrow", 3),
("EGKR", "Redhill, Redhill Aerodrome", 3),
("EGCC", "Manchester", 4),
("EGGP", "Liverpool, Liverpool John Lennon", 4),
("LEBL", "Barcelona", 5)
;
DROP TABLE airports;
SELECT * FROM airports;

-- IMPORTANT PUSH DATA FROM PYTHON FIRST BEFORE CONTINUING

CREATE TABLE IF NOT EXISTS cities_airports(
	city_code INT,
    icao VARCHAR(5),
    PRIMARY KEY (city_code, icao),
	FOREIGN KEY (icao) REFERENCES airports(icao),
    FOREIGN KEY (city_code) REFERENCES cities(city_code)
);
INSERT INTO cities_airports(city_code, icao) 
VALUES
(1, "EDDB"),
(2, "EDDH"),
(3, "EGKR"),
(3, "EGLC"),
(3, "EGLL"),
(4, "EGCC"),
(4, "EGGP"),
(5, "LEBL");
DROP TABLE cities_airports;
SELECT * FROM cities_airports;

-- create automatically updated tables
CREATE TABLE IF NOT EXISTS weather(
	weather_code INT AUTO_INCREMENT, 
	city_code INT, 
    city VARCHAR(50),
    country VARCHAR(50),
    latitude FLOAT(5),
    longitude FLOAT(5),
	date_time DATETIME,
    temperature FLOAT(2),
    felt_temperature FLOAT(2),
    weather VARCHAR(50),
    detailed_weather VARCHAR(50),
    risk_of_rain FLOAT(2),
    rain FLOAT(2),
    snow FLOAT(2),
    wind_speed FLOAT(2),
    retr_data DATETIME,
    PRIMARY KEY (weather_code),
    FOREIGN KEY (city_code) REFERENCES cities(city_code)
);
DROP TABLE weather;
SELECT * FROM weather;

CREATE TABLE IF NOT EXISTS flights(
	flight_code INT AUTO_INCREMENT, 
	icao VARCHAR(5), 
	flight_number VARCHAR(10), 
    departure_icao VARCHAR(5),
    arrival_TimeLocal DATETIME,
    arrival_terminal VARCHAR(3), 
    airline_name VARCHAR(50),
    retr_date DATETIME,
    PRIMARY KEY (flight_code),
	FOREIGN KEY (icao) REFERENCES airports(icao)
);
DROP TABLE flights;
SELECT * FROM flights;

CREATE TABLE IF NOT EXISTS sunlight(
	sunlight_code INT auto_increment,
    city_code INT,
    city VARCHAR(50),
    sunrise DATETIME,
    sunset DATETIME,
    retr_data DATETIME,
    PRIMARY KEY (sunlight_code),
    FOREIGN KEY (city_code) REFERENCES weather(city_code)
);
DROP TABLE sunlight;
SELECT * FROM sunlight;

-- to check if data got updated, change date to todays or yesterdays date
select * from weather
where retr_data 
like ('2023-03-10 %');