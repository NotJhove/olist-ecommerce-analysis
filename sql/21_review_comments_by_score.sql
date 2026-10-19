-- 21_review_comments_by_score.sql

SELECT TOP 20
    review_score,
    review_comment_message
FROM dbo.reviews
WHERE review_comment_message IS NOT NULL
  AND LTRIM(RTRIM(review_comment_message)) <> ''
ORDER BY review_score ASC;

SELECT
    review_score,
    COUNT(*) AS reviews_with_comments
FROM dbo.reviews
WHERE review_comment_message IS NOT NULL
  AND LTRIM(RTRIM(review_comment_message)) <> ''
GROUP BY review_score
ORDER BY review_score;