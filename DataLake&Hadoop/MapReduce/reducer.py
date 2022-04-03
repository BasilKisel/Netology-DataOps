import sys

keywords = dict()
for line in sys.stdin:
    word, weight = line.split(',')
    keywords[word] = keywords.get(word, 0) + int(weight)

for key, count in keywords.items():
    print(f'{key},{count}')
