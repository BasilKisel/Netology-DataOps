#!/usr/bin/env bash
clickhouse-client -q "CREATE DATABASE homework;"
clickhouse-client -d 'homework' -q '
    CREATE TABLE homework.metrika
    (
        "EventDate" Date,
        "CounterID" UInt32,
        "UserID" UInt64,
        "RegionID" UInt32
    )
    ENGINE = MergeTree()
    PARTITION BY toYYYYMM(EventDate)
    ORDER BY (CounterID, EventDate, intHash32(UserID));
'
cat /tmp/metrika_sample.tsv | clickhouse-client --database homework --query "INSERT INTO metrika FORMAT TSV"
# Посчитайте какой пользователь UserID сделал больше всего просмотров страниц?
clickhouse-client -d 'homework' -q "
    SELECT 'UserID = ' || CAST(""UserID"" AS VARCHAR(20)), ' vw_cnt = ' || CAST(COUNT(*) AS VARCHAR(20)) AS ""vw_cnt"" FROM homework.metrika GROUP BY ""UserID"" ORDER BY COUNT(*) DESC LIMIT 1;
"