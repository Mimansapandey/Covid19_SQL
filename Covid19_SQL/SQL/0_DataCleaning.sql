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

-- Check for negative values in new_cases and new_deaths
SELECT * FROM PortfolioProject.CovidDeaths WHERE new_cases < 0 OR new_deaths < 0;

-- Check for unrealistic population values
SELECT * FROM PortfolioProject.CovidDeaths WHERE population < 1000;

