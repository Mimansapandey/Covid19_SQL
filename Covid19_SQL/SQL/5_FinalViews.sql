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
