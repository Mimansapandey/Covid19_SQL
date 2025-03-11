-- Select total cases and deaths over time for visualization

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

-- Add Cases and Deaths by Continent

CREATE VIEW Continent_CovidTrends AS
SELECT 
    continent, 
    date, 
    SUM(new_cases) AS DailyNewCases, 
    SUM(new_deaths) AS DailyNewDeaths,
    SUM(total_cases) AS CumulativeCases,
    SUM(total_deaths) AS CumulativeDeaths
FROM PortfolioProject.CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent, date
ORDER BY date;

-- Top 10 Countries with most Deaths 

CREATE VIEW Top10_Deaths_Countries AS
SELECT location, MAX(total_deaths) AS TotalDeaths
FROM PortfolioProject.CovidDeaths
WHERE continent IS NOT NULL
AND location NOT IN ('Africa', 'Asia', 'Europe', 'North America', 'Oceania', 'South America')
GROUP BY location
ORDER BY TotalDeaths DESC
LIMIT 10;

-- Vaccination Progress by Country 

CREATE VIEW Vaccination_Progress AS
SELECT vac.location, vac.date, 
       MAX(vac.people_vaccinated) AS TotalPeopleVaccinated,
       dea.population, 
       ROUND((MAX(vac.people_vaccinated) / NULLIF(dea.population, 0)) * 100, 2) AS VaccinationRate
FROM PortfolioProject.CovidVaccinations vac
JOIN PortfolioProject.CovidDeaths dea
ON vac.location = dea.location
AND vac.date = dea.date
WHERE dea.continent IS NOT NULL
GROUP BY vac.location, vac.date, dea.population
ORDER BY vac.date;

-- Rolling 7-Day Average for Cases and Deaths

CREATE VIEW RollingAvg_Cases_Deaths AS
SELECT 
    location, 
    date, 
    new_cases, 
    new_deaths,
    AVG(new_cases) OVER (PARTITION BY location ORDER BY date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS RollingAvgNewCases,
    AVG(new_deaths) OVER (PARTITION BY location ORDER BY date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS RollingAvgNewDeaths
FROM PortfolioProject.CovidDeaths
WHERE continent IS NOT NULL;
