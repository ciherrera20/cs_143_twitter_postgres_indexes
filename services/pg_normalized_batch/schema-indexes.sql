CREATE INDEX ON tweet_tags(tag text_pattern_ops, id_tweets);
CREATE INDEX ON tweets USING GIN(to_tsvector('english', text));
