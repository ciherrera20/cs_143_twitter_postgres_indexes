/*
 * Count the number of English tweets containing the word "coronavirus"
 */
SELECT
    count(*)
FROM (
    SELECT
        data->>'id'
    FROM tweets_jsonb
    WHERE
        to_tsvector('english',data->'extended_tweet'->>'full_text')@@to_tsquery('english','coronavirus') AND
        data->>'lang'='en'
    UNION ALL
    SELECT
        data->>'id'
    FROM tweets_jsonb
    WHERE
        data->'extended_tweet'->'full_text' IS NULL AND
        to_tsvector('english',data->>'text')@@to_tsquery('english','coronavirus') AND
        data->>'lang'='en'
) t;
