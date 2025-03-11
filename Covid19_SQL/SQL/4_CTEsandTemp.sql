-- Using CTE to Perform Calculation on Partition By in Previous Query

WITH PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated) AS (
    SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
        SUM(CONVERT(int, vac.new_vaccinations)) OVER (PARTITION BY dea.Location ORDER BY dea.location, dea.Date) AS RollingPeopleVaccinated
    --, (RollingPeopleVaccinated / population) * 100
    FROM PortfolioProject.CovidDeaths dea
    JOIN PortfolioProject.CovidVaccinations vac
        ON dea.location = vac.location
        AND dea.date = vac.date
    WHERE dea.continent IS NOT NULL
)
SELECT *, (RollingPeopleVaccinated / Population) * 100 AS PercentVaccinated
FROM PopvsVac;

-- Using Temp Table to perform Calculation on Partition By in previous query

DROP TABLE IF EXISTS #PercentPopulationVaccinated;

CREATE TABLE #PercentPopulationVaccinated (
    Continent NVARCHAR(255),
    Location NVARCHAR(255),
    Date DATETIME,
    Population NUMERIC,
    New_vaccinations NUMERIC,
    RollingPeopleVaccinated NUMERIC
);

INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
    SUM(CONVERT(INT, vac.new_vaccinations)) OVER (PARTITION BY dea.Location ORDER BY dea.location, dea.Date) AS RollingPeopleVaccinated
--, (RollingPeopleVaccinated / population) * 100
FROM PortfolioProject.CovidDeaths dea
JOIN PortfolioProject.CovidVaccinations vac
    ON dea.location = vac.location
    AND dea.date = vac.date;

-- Retrieve Data from the Temporary Table
SELECT *, (RollingPeopleVaccinated / Population) * 100 AS PercentVaccinated
FROM #PercentPopulationVaccinated;

--  Rolling Sum for New Cases & Deaths

WITH RollingCasesDeaths AS (
    SELECT 
        dea.continent, 
        dea.location, 
        dea.date, 
        dea.population, 
        dea.new_cases, 
        dea.new_deaths,
        SUM(dea.new_cases) OVER (PARTITION BY dea.location ORDER BY dea.date) AS RollingTotalCases,
        SUM(dea.new_deaths) OVER (PARTITION BY dea.location ORDER BY dea.date) AS RollingTotalDeaths
    FROM PortfolioProject.CovidDeaths dea
    WHERE dea.continent IS NOT NULL
)
SELECT *, (RollingTotalCases / NULLIF(population, 0)) * 100 AS InfectionRate
FROM RollingCasesDeaths;

-- 7-Day Average for Reproduction Rate

WITH RollingReproduction AS (
    SELECT 
        location, 
        date, 
        reproduction_rate,
        AVG(reproduction_rate) OVER (PARTITION BY location ORDER BY date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS RollingAvgReproduction
    FROM PortfolioProject.CovidDeaths
    WHERE reproduction_rate IS NOT NULL
)
SELECT * FROM RollingReproduction;

