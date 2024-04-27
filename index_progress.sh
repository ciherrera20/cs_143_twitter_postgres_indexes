#!/bin/bash

docker-compose exec pg_denormalized psql -c "
SELECT
  round(p.blocks_done / p.blocks_total::numeric * 100, 2) AS progress
FROM pg_stat_progress_create_index p
JOIN pg_stat_activity a ON p.pid = a.pid
LEFT JOIN pg_stat_all_indexes ai on ai.relid = p.relid AND ai.indexrelid = p.index_relid;
" 2> /dev/null
