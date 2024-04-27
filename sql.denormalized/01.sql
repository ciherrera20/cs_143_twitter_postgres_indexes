/*
 * Count the number of tweets that use #coronavirus
 */
SELECT
    count(distinct data ->> 'id'::text)
FROM tweets_jsonb
WHERE
    data->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'::jsonb OR
    data->'extended_tweet'->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'::jsonb;

/*
SELECT
    DISTINCT t.id_tweets,
    '$'::text || (t.jsonb ->> 'text'::text) AS tag
FROM (
    SELECT
        tweets_jsonb.data ->> 'id'::text AS id_tweets,
        jsonb_array_elements(
            COALESCE((tweets_jsonb.data -> 'entities'::text) -> 'symbols'::text, '[]'::
jsonb) ||
            COALESCE(((tweets_jsonb.data -> 'extended_tweet'::text) -> 'entities'::text
) -> 'symbols'::text, '[]'::jsonb)
        ) AS jsonb
    FROM tweets_jsonb
) t
UNION ALL
SELECT
    DISTINCT t.id_tweets,
    '#'::text || (t.jsonb ->> 'text'::text) AS tag
FROM (
    SELECT
        tweets_jsonb.data ->> 'id'::text AS id_tweets,
        jsonb_array_elements(
            COALESCE((tweets_jsonb.data -> 'entities'::text) -> 'hashtags'::text, '[]'::jsonb) ||
            COALESCE(((tweets_jsonb.data -> 'extended_tweet'::text) -> 'entities'::text) -> 'hashtags'::text, '[]'::jsonb)
        ) AS jsonb
    FROM tweets_jsonb
) t;
*/
