# on Windows 10 and Cygwin, utf8 needs to be enforced
cat ./keywords.csv | python -X utf8 ./mapper.py | sort | python -X utf8 ./reducer.py 
