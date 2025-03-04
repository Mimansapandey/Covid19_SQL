-- Data Exploration

-- View all data
SELECT * 
FROM PortfolioProject.CovidDeaths
ORDER BY 3, 4;

-- Selecting Relevant Data
SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject.CovidDeaths
ORDER BY 1, 2;

-- Covid vaccinations
SELECT *
From PortfolioProject.CovidVaccinations;

SELECT *
From PortfolioProject.CovidDeaths dea
JOIN PortfolioProject.CovidVaccinations vac
    ON dea.location = vac.location
    and dea.date = dea.date;
