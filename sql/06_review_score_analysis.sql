-- 06_review_score_analysis.sql

SELECT
    review_score,
    COUNT(*) AS total_reviews,
    CAST(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*)
         FROM dbo.reviews
         WHERE review_score IS NOT NULL)
        AS DECIMAL(5, 2)
    ) AS percentage_of_reviews
FROM dbo.reviews
WHERE review_score IS NOT NULL
GROUP BY review_score
ORDER BY review_score DESC;