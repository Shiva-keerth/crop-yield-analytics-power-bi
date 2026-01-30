-- =============================================
-- Crop Yield Analytics SQL Analysis (SQL Server)
-- =============================================

-- 1. Total Records
SELECT COUNT(*) AS total_records
FROM crop_yield_dataset;

-- 2. Unique Crops Count
SELECT COUNT(DISTINCT Crop) AS total_crops
FROM crop_yield_dataset;

-- 3. Average Yield Overall
SELECT AVG(Yield_ton_per_ha) AS avg_yield
FROM crop_yield_dataset;

-- 4. Average Yield per Crop
SELECT Crop, AVG(Yield_ton_per_ha) AS avg_yield
FROM crop_yield_dataset
GROUP BY Crop
ORDER BY avg_yield DESC;

-- 5. Top 5 Crops by Yield
SELECT TOP 5 Crop, AVG(Yield_ton_per_ha) AS avg_yield
FROM crop_yield_dataset
GROUP BY Crop
ORDER BY avg_yield DESC;

-- 6. Yield by Region
SELECT Region, AVG(Yield_ton_per_ha) AS avg_yield
FROM crop_yield_dataset
GROUP BY Region
ORDER BY avg_yield DESC;

-- 7. Soil Type Impact
SELECT Soil_Type, AVG(Yield_ton_per_ha) AS avg_yield
FROM crop_yield_dataset
GROUP BY Soil_Type
ORDER BY avg_yield DESC;

-- 8. Irrigation Impact
SELECT Irrigation, AVG(Yield_ton_per_ha) AS avg_yield
FROM crop_yield_dataset
GROUP BY Irrigation
ORDER BY avg_yield DESC;

-- 9. Crop + Irrigation Combination
SELECT Crop, Irrigation, AVG(Yield_ton_per_ha) AS avg_yield
FROM crop_yield_dataset
GROUP BY Crop, Irrigation
ORDER BY avg_yield DESC;

-- 10. Rainfall Level vs Yield
SELECT
  CASE
    WHEN Rainfall_mm < 500 THEN 'Low Rain'
    WHEN Rainfall_mm BETWEEN 500 AND 1000 THEN 'Medium Rain'
    ELSE 'High Rain'
  END AS rainfall_level,
  AVG(Yield_ton_per_ha) AS avg_yield
FROM crop_yield_dataset
GROUP BY
  CASE
    WHEN Rainfall_mm < 500 THEN 'Low Rain'
    WHEN Rainfall_mm BETWEEN 500 AND 1000 THEN 'Medium Rain'
    ELSE 'High Rain'
  END
ORDER BY avg_yield DESC;

-- 11. Temperature Band vs Yield
SELECT
  CASE
    WHEN Temperature_C < 20 THEN 'Cold'
    WHEN Temperature_C BETWEEN 20 AND 30 THEN 'Moderate'
    ELSE 'Hot'
  END AS temp_band,
  AVG(Yield_ton_per_ha) AS avg_yield
FROM crop_yield_dataset
GROUP BY
  CASE
    WHEN Temperature_C < 20 THEN 'Cold'
    WHEN Temperature_C BETWEEN 20 AND 30 THEN 'Moderate'
    ELSE 'Hot'
  END
ORDER BY avg_yield DESC;

-- 12. Fertilizer Efficiency
SELECT Crop,
       AVG(Yield_ton_per_ha / NULLIF(Fertilizer_Used_kg,0)) AS yield_per_kg_fertilizer
FROM crop_yield_dataset
GROUP BY Crop
ORDER BY yield_per_kg_fertilizer DESC;

-- 13. Pesticide Efficiency
SELECT Crop,
       AVG(Yield_ton_per_ha / NULLIF(Pesticides_Used_kg,0)) AS yield_per_kg_pesticide
FROM crop_yield_dataset
GROUP BY Crop
ORDER BY yield_per_kg_pesticide DESC;

-- 14. Previous Crop Impact
SELECT Previous_Crop, AVG(Yield_ton_per_ha) AS avg_yield
FROM crop_yield_dataset
GROUP BY Previous_Crop
ORDER BY avg_yield DESC;

-- 15. Soil pH Band vs Yield
SELECT
  CASE
    WHEN Soil_pH < 6 THEN 'Acidic'
    WHEN Soil_pH BETWEEN 6 AND 7.5 THEN 'Neutral'
    ELSE 'Alkaline'
  END AS ph_band,
  AVG(Yield_ton_per_ha) AS avg_yield
FROM crop_yield_dataset
GROUP BY
  CASE
    WHEN Soil_pH < 6 THEN 'Acidic'
    WHEN Soil_pH BETWEEN 6 AND 7.5 THEN 'Neutral'
    ELSE 'Alkaline'
  END
ORDER BY avg_yield DESC;

-- 16. Highest Yield Record
SELECT TOP 1
    Crop,
    Region,
    Soil_Type,
    Irrigation,
    Yield_ton_per_ha
FROM crop_yield_dataset
ORDER BY Yield_ton_per_ha DESC;

-- 17. Lowest Yield Record
SELECT TOP 1
    Crop,
    Region,
    Soil_Type,
    Irrigation,
    Yield_ton_per_ha
FROM crop_yield_dataset
ORDER BY Yield_ton_per_ha ASC;

-- 18. Top Region + Crop Combinations
SELECT TOP 10
    Region,
    Crop,
    AVG(Yield_ton_per_ha) AS avg_yield
FROM crop_yield_dataset
GROUP BY Region, Crop
ORDER BY avg_yield DESC;

-- 19. Missing Value Check
SELECT
  SUM(CASE WHEN Previous_Crop IS NULL THEN 1 ELSE 0 END) AS null_previous_crop
FROM crop_yield_dataset;

-- 20. Records with Above Average Yield
SELECT *
FROM crop_yield_dataset
WHERE Yield_ton_per_ha >
      (SELECT AVG(Yield_ton_per_ha) FROM crop_yield_dataset);
