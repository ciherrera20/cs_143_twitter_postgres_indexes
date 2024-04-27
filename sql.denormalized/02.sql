/*
 * Calculates the hashtags that are commonly used with the hashtag #coronavirus
 */
SELECT
    tag,
    count(*) as count
FROM
(
    SELECT DISTINCT
        data ->> 'id',
        '#' || (jsonb_array_elements(
            COALESCE(data->'entities'->'hashtags','[]') ||
            COALESCE(data->'extended_tweet'->'entities'->'hashtags','[]')
        ) ->> 'text') AS tag
    FROM tweets_jsonb
    WHERE
        (data->'entities'->'hashtags' @> '[{"text":"coronavirus"}]'::jsonb OR
        data->'extended_tweet'->'entities'->'hashtags' @> '[{"text":"coronavirus"}]'::jsonb)
) t
GROUP BY tag
ORDER BY count DESC, tag
LIMIT 1000;
