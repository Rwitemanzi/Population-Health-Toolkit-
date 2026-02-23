
USE CIS_3107_01

/* ====================================================================
-- Database Modeling Final Project 
--	SQL Script Final Project for The Population Health.
--	This script will drop, re-create tables and 
--  then insert the records into the tables for the Population Health
--	Created by: Bamlak Amedie
		    Sr. Joana Charles 
		    Yohanan Bisrat  
--	Created on:  12/9/2024
-- ==================================================================== */

-- DROP all tables from Population Health Toolkit if they are stored
IF OBJECT_ID ('countyHospital')	IS NOT NULL DROP TABLE countyHospital;
IF OBJECT_ID ('hospitalMeasure') IS NOT NULL  DROP TABLE hospitalMeasure;
IF OBJECT_ID ('measure') IS NOT NULL DROP TABLE measure;
IF OBJECT_ID ('hospital') IS NOT NULL DROP TABLE hospital;
IF OBJECT_ID ('county')	IS NOT NULL DROP TABLE county;

-- Create tables and insert records

BEGIN;
-- Create the county table
CREATE TABLE county (
	county_FIPS_ID       VARCHAR(5)	NOT NULL UNIQUE,
	county_name          VARCHAR(20),
	county_state         CHAR(2),
	county_population    INT,
	county_percentage    NUMERIC(4, 2),
PRIMARY KEY(county_FIPS_ID));


-- Create the hospital table
CREATE TABLE hospital (
	hosp_id       VARCHAR(5)	NOT NULL	UNIQUE,
	hosp_name     VARCHAR(30),
	hosp_type     VARCHAR(20),
	hosp_owner    VARCHAR(40),
	hosp_address  VARCHAR(25),
	hosp_city     CHAR(10),
	hosp_zip      CHAR(5),
	hosp_percentage DECIMAL (3, 2),
PRIMARY KEY(hosp_id ));


-- Create the measure table
CREATE TABLE measure (
	measure_id     VARCHAR(6) NOT NULL UNIQUE,
	county_FIPS_ID    VARCHAR(5)	NOT NULL,
	measure_name    VARCHAR(41),
PRIMARY KEY(measure_id),
FOREIGN KEY(county_FIPS_ID)     REFERENCES county);

-- Create the  countyHospital table
CREATE TABLE countyHospital (
      hosp_id   VARCHAR(5) NOT NULL,
	  county_FIPS_ID  VARCHAR(5)	NOT NULL,
PRIMARY KEY (hosp_id, county_FIPS_ID),
FOREIGN KEY(hosp_id) REFERENCES hospital,
FOREIGN KEY(county_FIPS_ID) REFERENCES county);

-- Create the hospitalMeasure table
CREATE TABLE hospitalMeasure(
	hosp_id           VARCHAR(5) NOT NULL,
	measure_id             VARCHAR(6) NOT NULL,
PRIMARY KEY (hosp_id, measure_id),
FOREIGN KEY(hosp_id) REFERENCES hospital,
FOREIGN KEY(measure_id) REFERENCES measure);


--        INSERT TABLES RECORDS
---- Create county records
INSERT INTO county (county_FIPS_ID,county_name,county_state,county_population,county_percentage)
    VALUES('01001', 'AUTAUGA', 'AL', '59095', 0.42);
INSERT INTO county (county_FIPS_ID,county_name,county_state,county_population,county_percentage)
	VALUES('01003', 'BALDWIN', 'AL', '239294', 0.42);
INSERT INTO county (county_FIPS_ID,county_name,county_state,county_population,county_percentage)
	VALUES('01069', 'HOUSTON', 'AL', '107458', 0.33);
INSERT INTO county (county_FIPS_ID,county_name,county_state,county_population,county_percentage)
	VALUES('01077', 'LAUDERDALE', 'AL', '94043', 0.49);
INSERT INTO county (county_FIPS_ID,county_name,county_state,county_population,county_percentage)
	VALUES('01089', 'MADISON', 'AL', '395211', 0.16);

---- Create hospital records
INSERT INTO hospital(hosp_id,hosp_name,hosp_type,hosp_owner,hosp_address,hosp_city,hosp_zip,hosp_percentage)
	   VALUES('10108','Prattville Baptist Hospital','Acute Care','Government', '1245 Memorial DR','Prattville','36067', 0.42);
INSERT INTO hospital(hosp_id,hosp_name,hosp_type,hosp_owner,hosp_address,hosp_city,hosp_zip,hosp_percentage)
	   VALUES('10100','Thomas Hospital','Acute Care','Private', '750 Morphy Avenue','Fairhope','36532',0.42);
INSERT INTO hospital(hosp_id,hosp_name,hosp_type,hosp_owner,hosp_address,hosp_city,hosp_zip,hosp_percentage)
	   VALUES('10055','Flowers Hospital','Acute Care','Proprietary','4370 West Main Street','Dothan','36305', 0.33);
INSERT INTO hospital(hosp_id,hosp_name,hosp_type,hosp_owner,hosp_address,hosp_city,hosp_zip,hosp_percentage)
	   VALUES('10006','North Albama Medical Center','Acute Care','Proprietary', '1701 Veterans Drive','Florence','35630', 0.49);
INSERT INTO hospital(hosp_id,hosp_name,hosp_type,hosp_owner,hosp_address,hosp_city,hosp_zip,hosp_percentage)
	   VALUES('10039','Huntsville hospital','Acute Care','Government', '101 Sivley Rd','Huntsville','35801', 0.16);

---- Create measure records
INSERT INTO measure(measure_id, county_FIPS_ID, measure_name)
	    VALUES('PSI_03', '01001', 'Pressure ulcer rate');
INSERT INTO measure(measure_id, county_FIPS_ID, measure_name)
	    VALUES('PSI_06', '01003', 'Iatrogenic pneumothorax rate');
INSERT INTO measure(measure_id, county_FIPS_ID, measure_name)
	    VALUES('PSI_08', '01069', 'In-hospital fall-associated fracture rate');
INSERT INTO measure(measure_id, county_FIPS_ID, measure_name)
	    VALUES('PSI_11', '01077', 'Postoperative respiratory failure rate');
INSERT INTO measure(measure_id, county_FIPS_ID, measure_name)
	    VALUES('PSI_13', '01089', 'Postoperative sepsis rate');


 ---- Create hospitalMeasure records
INSERT INTO hospitalMeasure(hosp_id,  measure_id)
	    VALUES('10108', 'PSI_03');
INSERT INTO hospitalMeasure(hosp_id,  measure_id)
	    VALUES('10100', 'PSI_06');
INSERT INTO hospitalMeasure(hosp_id,  measure_id)
	    VALUES('10055', 'PSI_08');
INSERT INTO hospitalMeasure(hosp_id,  measure_id)
	    VALUES('10006', 'PSI_11');
INSERT INTO hospitalMeasure(hosp_id,  measure_id)
	    VALUES('10039', 'PSI_13');


 ---- Create countyHospital records
INSERT INTO countyHospital(hosp_id, county_FIPS_ID)
	    VALUES('10108', '01001');
INSERT INTO countyHospital(hosp_id, county_FIPS_ID)
	    VALUES('10100', '01003');
INSERT INTO countyHospital(hosp_id, county_FIPS_ID)
	    VALUES('10055', '01069');
INSERT INTO countyHospital(hosp_id, county_FIPS_ID)
	    VALUES('10006', '01077');
INSERT INTO countyHospital(hosp_id, county_FIPS_ID)
	    VALUES('10039', '01089');

		
/* ====================================================================
--  Select Script for the Population Health
--  To be used with Reset Script above
--	Created by: Bamlak Amedie
		    Sr. Joana Charles 
		    Yohanan Bisrat 
--	Created on:  12/9/2024
-- ==================================================================== */

--Identify government-owned hospitals along with their addresses, and determine
--which Patient Safety Indicators (PSIs) are associated with each of these hospitals?

SELECT m. measure_id AS 'PSI', h.hosp_name, h.hosp_owner, h.hosp_address AS 'Address'   
FROM measure m, hospital h
WHERE h.hosp_owner= 'Government';

--Find counties with a population greater than 100,000.

 SELECT county_name, county_state, county_population
FROM county
WHERE CAST(county_population AS INT) > 100000;

--Find hospitals with a percentage less than 0.4 and their corresponding counties.
SELECT h.hosp_name, h.hosp_percentage, c.county_name
FROM hospital h
JOIN countyHospital ch ON h.hosp_id = ch.hosp_id
JOIN county c ON ch.county_FIPS_ID = c.county_FIPS_ID
WHERE h.hosp_percentage < 0.4;

--Count the number of hospitals per county.
SELECT c.county_name, COUNT(ch.hosp_id) AS hospital_count
FROM county c
JOIN countyHospital ch ON c.county_FIPS_ID = ch.county_FIPS_ID
GROUP BY c.county_name;

-- Show the average percentage of hospitals for each county.
SELECT c.county_name, AVG(h.hosp_percentage) AS avg_hospital_percentage
FROM county c
JOIN countyHospital ch ON c.county_FIPS_ID = ch.county_FIPS_ID
JOIN hospital h ON ch.hosp_id = h.hosp_id
GROUP BY c.county_name;

END;

