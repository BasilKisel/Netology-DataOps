import sys
import csv

trans_tbl = str.maketrans(
        ' \t,_!./?\\|!@#$%^&*()-+=$^:;"\'`~',
        '                               '
)
reader = csv.DictReader(sys.stdin)
for kw in reader:
    for word in kw['keyword'].translate(trans_tbl).split():
        if word.isalpha():
            print(f'{word.lower()},1')
