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
