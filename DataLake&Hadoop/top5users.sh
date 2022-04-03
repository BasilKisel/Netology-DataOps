# Get the top 5 of the most active users with rating's count
$ tail -n +2 ./hdfs/ml-latest-small/ratings.csv | cut -d ',' -f 1 | sort -n | uniq -c | sort -n -r | head -n 5
   2698 414
   2478 599
   2108 474
   1864 448
   1346 274

# Get the top 5 of the most active users
$ tail -n +2 ./hdfs/ml-latest-small/ratings.csv | cut -d ',' -f 1 | sort -n | uniq -c | sort -n -r | sed "s/^ \+//g" | cut -d ' ' -f 2 | head -n 5
414
599
474
448
274

# where I do the following:
# 1 skip the header
# 2 extract user IDs
# 3 sort user IDs
# 4 count user IDs
# 5 sort by rating's amount descendently
# 6 get rid of the leading blankspaces that break cut's logic
# 7 drop the count column
# 8 show the top 5 of the most active users