SELECT
    date_date,
    ROUND(SUM(revenue), 2) AS revenue,
    SUM(quantity) AS quantity
FROM `fast-archive-478610-v8.gz_raw_data.raw_gz_sales`
GROUP BY date_date
ORDER BY date_date DESC