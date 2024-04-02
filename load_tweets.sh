#!/bin/sh

# list all of the files that will be loaded into the database
# for the first part of this assignment, we will only load a small test zip file with ~10000 tweets
# but we will write our code so that we can easily load an arbitrary number of files
files='
test-data.zip
'
pg_denormalized_port=13421
pg_normalized_port=13422
pg_denormalized_url="postgresql://postgres:pass@localhost:$pg_denormalized_port/postgres"
pg_normalized_url="postgresql://postgres:pass@localhost:$pg_normalized_port/postgres"


echo 'load normalized'
for file in $files; do
    # call the load_tweets.py file to load data into pg_normalized
    ./load_tweets.py --db $pg_normalized_url --inputs $file
done

# echo 'load denormalized'
# for file in $files; do
#     unzip -p $file | sed 's/\\u0000//g' | psql $pg_denormalized_url -c "COPY tweets_jsonb (data) FROM STDIN csv quote e'\x01' delimiter e'\x02';"
# done
