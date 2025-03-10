-- Creating Views for Key COVID-19 Insights

-- View for total cases and deaths by date (Global Level)
CREATE VIEW Global_CovidTrends AS
SELECT 
    date, 
    SUM(new_cases) AS TotalNewCases, 
    SUM(new_deaths) AS TotalNewDeaths,
    SUM(total_cases) AS CumulativeCases,
    SUM(total_deaths) AS CumulativeDeaths
FROM PortfolioProject.CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY date;

-- Top Infection Rates

CREATE VIEW TopInfectionRates AS
SELECT 
    location, 
    MAX(total_cases) AS HighestInfectionCount, 
    population, 
    MAX((total_cases / NULLIF(population, 0)) * 100) AS PercentPopulationInfected
FROM PortfolioProject.CovidDeaths
WHERE continent IS NOT NULL
AND location NOT IN ('Africa', 'Asia', 'Europe', 'North America', 'Oceania', 'South America')
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC;

-- Fatality Rate By Continent 

CREATE VIEW FatalityRateByContinent AS
SELECT continent, 
       SUM(total_cases) AS TotalCases, 
       SUM(total_deaths) AS TotalDeaths, 
       ROUND((SUM(total_deaths) / NULLIF(SUM(total_cases), 0)) * 100, 2) AS CaseFatalityRate
FROM PortfolioProject.CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY CaseFatalityRate DESC;

-- Vaccination Rates By Country

CREATE VIEW VaccinationRateByCountry AS
SELECT vac.location, 
       MAX(vac.people_vaccinated) AS TotalPeopleVaccinated,
       dea.population, 
       ROUND((MAX(vac.people_vaccinated) / NULLIF(dea.population, 0)) * 100, 2) AS VaccinationRate
FROM PortfolioProject.CovidVaccinations vac
JOIN PortfolioProject.CovidDeaths dea
ON vac.location = dea.location
WHERE dea.continent IS NOT NULL
AND vac.location NOT IN ('Africa', 'Asia', 'Europe', 'North America', 'Oceania', 'South America')
GROUP BY vac.location, dea.population
ORDER BY VaccinationRate DESC;

-- Highest Death Count By Continent

CREATE VIEW HighestDeathCountsByContinent AS
SELECT continent, MAX(total_deaths) AS TotalDeathCount 
FROM PortfolioProject.CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC;

-- Daily Cases By Continent 

CREATE VIEW DailyCasesByContinent AS
SELECT 
    continent, 
    date, 
    SUM(new_cases) AS DailyNewCases, 
    SUM(new_deaths) AS DailyNewDeaths
FROM PortfolioProject.CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent, date
ORDER BY date, continent;

-- View: Maximum Death Rate Per Country
CREATE VIEW MaxDeathRatePerCountry AS 
SELECT 
    continent,
    location,
    population,
    MAX(total_deaths) AS max_total_deaths,
    MAX(total_deaths / population) * 100 AS max_death_rate
FROM PortfolioProject.CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent, location, population
ORDER BY max_death_rate DESC;

-- View Data from MaxDeathRatePerCountry
SELECT * FROM MaxDeathRatePerCountry;
