-- 20_review_comment_availability.sql

SELECT
    COUNT(*) AS total_reviews,
    SUM(
        CASE
            WHEN review_comment_message IS NOT NULL
                 AND LTRIM(RTRIM(review_comment_message)) <> ''
            THEN 1
            ELSE 0
        END
    ) AS reviews_with_comments,
    SUM(
        CASE
            WHEN review_comment_message IS NULL
                 OR LTRIM(RTRIM(review_comment_message)) = ''
            THEN 1
            ELSE 0
        END
    ) AS reviews_without_comments
FROM dbo.reviews;