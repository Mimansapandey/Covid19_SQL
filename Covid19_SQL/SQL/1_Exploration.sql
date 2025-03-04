-- Data Exploration

-- View all data
SELECT * 
FROM PortfolioProject.CovidDeaths
ORDER BY 3, 4;

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
