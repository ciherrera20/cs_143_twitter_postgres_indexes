/*
 * Count the number of English tweets containing the word "coronavirus"
 */
SELECT
    count(*)
FROM tweets_jsonb
WHERE
    (
        to_tsvector('english',data->'extended_tweet'->>'full_text')@@to_tsquery('english','coronavirus') OR
        (
            data->'extended_tweet'->>'full_text' IS NULL AND
            to_tsvector('english',data->>'text')@@to_tsquery('english','coronavirus')
        )
    ) AND
    data->'lang'?'en';
