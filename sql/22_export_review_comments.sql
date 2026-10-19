-- 22_export_review_comments.sql

SELECT
    review_id,
    order_id,
    review_score,
    review_comment_message
FROM dbo.reviews
WHERE review_comment_message IS NOT NULL
  AND LTRIM(RTRIM(review_comment_message)) <> ''
ORDER BY review_score ASC;