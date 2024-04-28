/*
 * Count the number of tweets that use #coronavirus
 */
SELECT
    count(distinct data ->> 'id'::text)
FROM tweets_jsonb
WHERE
    data->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'::jsonb OR
    data->'extended_tweet'->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'::jsonb;
