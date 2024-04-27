CREATE INDEX ON tweets_jsonb USING GIN((data->'entities'->'hashtags') jsonb_path_ops);
CREATE INDEX ON tweets_jsonb USING GIN((data->'extended_tweet'->'entities'->'hashtags') jsonb_path_ops);
CREATE INDEX ON tweets_jsonb((data->>'lang'));
CREATE INDEX ON tweets_jsonb USING GIN(to_tsvector('english',data->>'text'));
CREATE INDEX ON tweets_jsonb USING GIN(to_tsvector('english',data->'extended_tweet'->>'full_text'));

