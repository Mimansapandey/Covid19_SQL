-- Creating Views for Key COVID-19 Insights

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
