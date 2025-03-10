-- Countries with Highest Infection Rates
SELECT 
    Location, 
    MAX(total_cases) AS HighestInfectionCount, 
    population, 
    MAX((total_cases / NULLIF(population, 0)) * 100) AS PercentPopulationInfected
FROM PortfolioProject.CovidDeaths
GROUP BY Location, population
ORDER BY PercentPopulationInfected DESC

-- Get min, max, avg of total cases and deaths
SELECT MIN(total_cases) FROM PortfolioProject.CovidDeaths;
SELECT MAX(total_cases) FROM PortfolioProject.CovidDeaths;
SELECT AVG(total_cases) FROM PortfolioProject.CovidDeaths;

SELECT MIN(total_deaths) FROM PortfolioProject.CovidDeaths;
SELECT MAX(total_deaths) FROM PortfolioProject.CovidDeaths;
SELECT AVG(total_deaths) FROM PortfolioProject.CovidDeaths;

-- Countries with Highest Death Count per Population

SELECT Location, MAX(total_deaths) AS TotalDeathCount 
FROM PortfolioProject.CovidDeaths
WHERE continent is not NULL
GROUP BY Location
ORDER BY TotalDeathCount DESC

-- Exploring Data on the basis of Continent

SELECT continent, MAX(total_deaths) AS TotalDeathCount 
FROM PortfolioProject.CovidDeaths
WHERE continent is not NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC

-- Continents with Highest Death Counts

SELECT continent, MAX(total_deaths) AS TotalDeathCount 
FROM PortfolioProject.CovidDeaths
WHERE continent is not NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC


-- Global Numbers
SELECT 
    date, 
    SUM(new_cases) AS total_cases, 
    SUM(new_deaths) AS total_deaths, 
    (SUM(new_deaths) / NULLIF(SUM(new_cases), 0)) * 100 AS DeathPercentage
FROM PortfolioProject.CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1, 2;

-- GLOBAL TOTAL 

SELECT 
    SUM(new_cases) AS total_cases, 
    SUM(new_deaths) AS total_deaths, 
    (SUM(new_deaths) / NULLIF(SUM(new_cases), 0)) * 100 AS DeathPercentage
FROM PortfolioProject.CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1, 2;
