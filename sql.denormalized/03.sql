/*
 * Calculates the languages that use the hashtag #coronavirus
 */
SELECT
    data->>'lang' AS lang,
    count(DISTINCT data->>'id') AS count
FROM tweets_jsonb
WHERE
    data->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'::jsonb OR
    data->'extended_tweet'->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'::jsonb
GROUP BY (1)
ORDER BY count DESC,(1);

