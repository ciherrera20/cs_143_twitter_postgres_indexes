CREATE INDEX ON tweets_jsonb USING GIN(
    (data->'extended_tweet'->'entities'->'hashtags') jsonb_path_ops,
    (data->'entities'->'hashtags') jsonb_path_ops
);
CREATE INDEX ON tweets_jsonb USING GIN(
    to_tsvector('english',data->'extended_tweet'->>'full_text'),
    to_tsvector('english',data->>'text'),
    (data->'lang')
);

