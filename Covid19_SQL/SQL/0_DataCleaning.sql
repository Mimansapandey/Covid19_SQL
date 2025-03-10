-- Checking for NULL values in key columns
SELECT 
    COUNT(*) AS TotalRows,
    SUM(CASE WHEN continent IS NULL THEN 1 ELSE 0 END) AS NullContinent,
    SUM(CASE WHEN total_cases IS NULL THEN 1 ELSE 0 END) AS NullTotalCases,
    SUM(CASE WHEN new_cases IS NULL THEN 1 ELSE 0 END) AS NullNewCases,
    SUM(CASE WHEN total_deaths IS NULL THEN 1 ELSE 0 END) AS NullTotalDeaths,
    SUM(CASE WHEN new_deaths IS NULL THEN 1 ELSE 0 END) AS NullNewDeaths,
    SUM(CASE WHEN icu_patients IS NULL THEN 1 ELSE 0 END) AS NullICUPatients,
    SUM(CASE WHEN hosp_patients IS NULL THEN 1 ELSE 0 END) AS NullHospPatients
FROM PortfolioProject.CovidDeaths;

SELECT 
    COUNT(*) AS TotalRows,
    SUM(CASE WHEN total_vaccinations IS NULL THEN 1 ELSE 0 END) AS NullTotalVaccinations,
    SUM(CASE WHEN people_vaccinated IS NULL THEN 1 ELSE 0 END) AS NullPeopleVaccinated,
    SUM(CASE WHEN new_vaccinations IS NULL THEN 1 ELSE 0 END) AS NullNewVaccinations,
    SUM(CASE WHEN tests_units IS NULL THEN 1 ELSE 0 END) AS NullTestsUnits
FROM PortfolioProject.CovidVaccinations;

-- Fill NULLs with 0 where necessary

-- Replace NULL values in numeric columns with 0
UPDATE PortfolioProject.CovidDeaths
SET total_cases = COALESCE(total_cases, 0),
    new_cases = COALESCE(new_cases, 0),
    total_deaths = COALESCE(total_deaths, 0),
    new_deaths = COALESCE(new_deaths, 0),
    icu_patients = COALESCE(icu_patients, 0),
    hosp_patients = COALESCE(hosp_patients, 0);

UPDATE PortfolioProject.CovidVaccinations
SET total_vaccinations = COALESCE(total_vaccinations, 0),
    people_vaccinated = COALESCE(people_vaccinated, 0),
    new_vaccinations = COALESCE(new_vaccinations, 0);

-- Replace NULL continent with 'Unknown'
UPDATE PortfolioProject.CovidDeaths
SET continent = COALESCE(continent, 'Unknown');

-- Verify NULLs in CovidDeaths Table

SELECT 
    SUM(CASE WHEN total_cases IS NULL THEN 1 ELSE 0 END) AS NullTotalCases,
    SUM(CASE WHEN new_cases IS NULL THEN 1 ELSE 0 END) AS NullNewCases,
    SUM(CASE WHEN total_deaths IS NULL THEN 1 ELSE 0 END) AS NullTotalDeaths,
    SUM(CASE WHEN new_deaths IS NULL THEN 1 ELSE 0 END) AS NullNewDeaths,
    SUM(CASE WHEN icu_patients IS NULL THEN 1 ELSE 0 END) AS NullICUPatients,
    SUM(CASE WHEN hosp_patients IS NULL THEN 1 ELSE 0 END) AS NullHospPatients
FROM PortfolioProject.CovidDeaths;

-- Verify NULLs in CovidVaccinations Table

SELECT 
    SUM(CASE WHEN total_vaccinations IS NULL THEN 1 ELSE 0 END) AS NullTotalVaccinations,
    SUM(CASE WHEN people_vaccinated IS NULL THEN 1 ELSE 0 END) AS NullPeopleVaccinated,
    SUM(CASE WHEN new_vaccinations IS NULL THEN 1 ELSE 0 END) AS NullNewVaccinations
FROM PortfolioProject.CovidVaccinations;

SELECT * FROM PortfolioProject.CovidDeaths 
WHERE total_cases IS NULL 
   OR new_cases IS NULL 
   OR total_deaths IS NULL 
   OR new_deaths IS NULL 
   OR icu_patients IS NULL 
   OR hosp_patients IS NULL;

SELECT DISTINCT continent FROM PortfolioProject.CovidDeaths;

-- Removing the duplicates from CovidDeaths
CREATE TEMPORARY TABLE TempDuplicates AS
SELECT date, location, total_cases,
       ROW_NUMBER() OVER (PARTITION BY date, location ORDER BY total_cases) AS row_num
FROM PortfolioProject.CovidDeaths;

DELETE FROM PortfolioProject.CovidDeaths
WHERE (date, location, total_cases) IN (
    SELECT date, location, total_cases FROM TempDuplicates WHERE row_num > 1
);

-- Removing the duplicates from CovidVaccinations


SELECT date, location, COUNT(*)
FROM PortfolioProject.CovidVaccinations
GROUP BY date, location
HAVING COUNT(*) > 1;

UPDATE PortfolioProject.CovidVaccinations
SET tests_units = 
    CASE 
        WHEN tests_units LIKE '%performed%' THEN 'tests performed'
        WHEN tests_units LIKE '%people%' THEN 'people tested'
        WHEN tests_units LIKE '%unclear%' THEN 'unknown'
        ELSE tests_units
    END;


-- Remove rows where date is NULL
DELETE FROM PortfolioProject.CovidDeaths WHERE date IS NULL;
DELETE FROM PortfolioProject.CovidVaccinations WHERE date IS NULL;

-- Ensure date is formatted correctly
ALTER TABLE PortfolioProject.CovidDeaths MODIFY COLUMN date DATE;
ALTER TABLE PortfolioProject.CovidVaccinations MODIFY COLUMN date DATE;


-- Remove rows where date is NULL
DELETE FROM PortfolioProject.CovidDeaths WHERE date IS NULL;
DELETE FROM PortfolioProject.CovidVaccinations WHERE date IS NULL;

-- Ensure date is formatted correctly
ALTER TABLE PortfolioProject.CovidDeaths MODIFY COLUMN date DATE;
ALTER TABLE PortfolioProject.CovidVaccinations MODIFY COLUMN date DATE;


DESCRIBE PortfolioProject.CovidDeaths;
SELECT * FROM PortfolioProject.CovidDeaths WHERE location = 'Vatican';

DELETE FROM PortfolioProject.CovidDeaths
WHERE population < 800 OR population > 1600000000;

SELECT DISTINCT population FROM PortfolioProject.CovidDeaths ORDER BY population DESC;

-- Check for negative values in new_cases and new_deaths
SELECT * FROM PortfolioProject.CovidDeaths WHERE new_cases < 0 OR new_deaths < 0;

-- Check for unrealistic population values
SELECT * FROM PortfolioProject.CovidDeaths WHERE population < 1000;

