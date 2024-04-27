#!/usr/bin/python3

# imports
import psycopg2
import sqlalchemy
import os
import datetime
import zipfile
import io
import json

if __name__ == '__main__':
    # create database connections
    engine_denormalized = sqlalchemy.create_engine('postgresql://postgres:pass@localhost:13421/' , connect_args={
        'application_name': 'compare_ids.py',
        })
    connection_denormalized = engine_denormalized.connect()
    engine_normalized = sqlalchemy.create_engine('postgresql://postgres:pass@localhost:13423/' , connect_args={
        'application_name': 'compare_ids.py',
        })
    connection_normalized = engine_normalized.connect()

    sql = sqlalchemy.sql.text('''
    SELECT data->>'id' FROM tweets_jsonb WHERE to_tsvector('english',data->>'text')@@to_tsquery('english','coronavirus');
    ''')
    rows_denormalized = connection_denormalized.execute(sql).fetchall()
    ids_denormalized = set([int(row.values()[0]) for row in rows_denormalized])
    
    sql = sqlalchemy.sql.text('''
    SELECT id_tweets FROM tweets WHERE to_tsvector('english',text)@@to_tsquery('english','coronavirus');
    ''')
    rows_normalized = connection_normalized.execute(sql).fetchall()
    ids_normalized = set([row.values()[0] for row in rows_normalized])

    ids_shared = ids_normalized.intersection(ids_denormalized)
    ids_denormalized_only = ids_denormalized - ids_shared
    ids_normalized_only = ids_normalized - ids_shared

