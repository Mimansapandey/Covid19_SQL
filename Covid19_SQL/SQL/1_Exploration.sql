-- Data Exploration

-- View all data
SELECT * 
FROM PortfolioProject.CovidDeaths
ORDER BY 3, 4;

SELECT COUNT(*) AS TotalRows FROM PortfolioProject.CovidDeaths;
SELECT COUNT(*) AS TotalRows FROM PortfolioProject.CovidVaccinations;

-- View first 10 rows
SELECT * FROM PortfolioProject.CovidDeaths LIMIT 10;
SELECT * FROM PortfolioProject.CovidVaccinations LIMIT 10;

-- View table structure
DESCRIBE PortfolioProject.CovidDeaths;
DESCRIBE PortfolioProject.CovidVaccinations;

-- Checking unique values in categorical columns
SELECT DISTINCT continent FROM PortfolioProject.CovidDeaths ORDER BY continent;
SELECT DISTINCT continent FROM PortfolioProject.CovidVaccinations ORDER BY continent;

SELECT DISTINCT location FROM PortfolioProject.CovidDeaths ORDER BY location;
SELECT DISTINCT location FROM PortfolioProject.CovidVaccinations ORDER BY location;
SELECT DISTINCT tests_units FROM PortfolioProject.CovidVaccinations ORDER BY tests_units;

-- Selecting Relevant Data
SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject.CovidDeaths
ORDER BY 1, 2;

-- Total Cases vs Total Deaths (Death Percentage Calculation)
SELECT Location, date, total_cases, total_deaths, 
       (total_deaths / NULLIF(total_cases, 0)) * 100 AS DeathPercentage
FROM PortfolioProject.CovidDeaths
ORDER BY 1, 2;

-- Country Specific Comparison
SELECT Location, date, total_cases, total_deaths, 
       (total_deaths / NULLIF(total_cases, 0)) * 100 AS DeathPercentage
FROM PortfolioProject.CovidDeaths
WHERE location LIKE '%United Kingdom%'
ORDER BY 1, 2;

-- Looking at Total Cases VS Population (Infection Rate)
SELECT Location, date, total_cases, population, 
       (NULLIF(total_cases, 0) / Population) * 100 AS InfectionRate
FROM PortfolioProject.CovidDeaths
WHERE location LIKE '%United Kingdom%'
ORDER BY 1, 2;

-- Death Percentage
SELECT Location, date, total_deaths, population, 
       (NULLIF(total_deaths, 0) / Population) * 100 AS DeathPercentage
FROM PortfolioProject.CovidDeaths
WHERE location LIKE '%United Kingdom%'
ORDER BY 1, 2;

-- Covid vaccinations
SELECT *
FROM PortfolioProject.CovidVaccinations;

-- Checking Join Between Deaths and Vaccinations Data
SELECT *
FROM PortfolioProject.CovidDeaths dea
JOIN PortfolioProject.CovidVaccinations vac
    ON dea.location = vac.location
    AND dea.date = vac.date;
