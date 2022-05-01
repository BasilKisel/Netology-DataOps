from pyspark import SparkContext

# I need a function to split a CSV line into words since I hardly can rely on any imported object like CSV module due to Spark's environment.
def tokenazeCSV(line, quotation_mark = '"', separator = ','):
    """
    Tokenizes CSV line into a sequence of columns.
    Honors double quotation marks as an escape sequence for a single quotation mark.
    """
    quoted = False
    escaped_or_unquoted = False
    value = []
    columns = []
    idx = 0
    for ch in line:
        if ch == separator and not quoted:
            columns.append(''.join(value))
            value = []
            escaped_or_unquoted = False
        elif ch == quotation_mark and quoted and not escaped_or_unquoted:
            escaped_or_unquoted = True
            quoted = False
        elif ch == quotation_mark and not quoted and escaped_or_unquoted:
            value.append(quotation_mark)
            escaped_or_unquoted = False
            quoted = True
        elif ch == quotation_mark and not escaped_or_unquoted:
            quoted = not quoted
        elif not escaped_or_unquoted:
            value.append(ch)
        else:
            raise Exception(f"""Illegal token in line: "{ch}" is illegal for state quoted = {quoted} and escaped_or_unquoted = {escaped_or_unquoted}\nposition[{idx}] in line: "{line}""")
        idx += 1
        # print(ch, quoted, escaped_or_unquoted, value)
    columns.append(''.join(value))
    return columns
# TESTS
# foo = "51357,Citizen X (1995),Crime|Drama|Thriller"
# bar = '51372,"""Great Performances"" Cats (1998)",Musical'
# bar = '"""foo""bar",baz'
# print(TokenazeCSV(foo))
# print(TokenazeCSV(bar))

def extractWords(line):
    chars = []
    words = []
    for ch in line:
        if str.isalpha(ch):
            chars.append(ch)
        elif len(chars) > 0:
            words.append(''.join(chars))
            chars = []
    return words


result_file = r'C:\v.kisel\tmp\Netology.ru\Netology-DataOps\AdvancedDataMethods\ApacheSparkIntro\results.txt'
input_file = r'C:\v.kisel\tmp\Netology.ru\Netology-DataOps\AdvancedDataMethods\ApacheSparkIntro\movies.csv'

sc = SparkContext.getOrCreate()
# Load and clean the data. A waste of CPU since in the real world there is no headers and empty strings.
data = sc.textFile(input_file).filter(lambda line: len(line) > 0 and line != r'movieId,title,genres')
words = data.map(lambda line: tokenazeCSV(line)[1]).flatMap(extractWords)
word_freq = words.map(lambda word: (word.lower(), 1)).reduceByKey(lambda acc1, acc2: acc1 + acc2).sortBy(lambda pair: -pair[1]).take(99)

# I need to write a file in this driver because cs.saveAsTextFile(...) tries to same the result as if it works with hadoop filesystem.
with open(result_file, encoding = 'UTF8', mode = 'w') as res_file:
    for res_line in word_freq:
        res_file.write(str(res_line))
        res_file.write("\n")

# .saveAsTextFile(r'C:\v.kisel\tmp\Netology.ru\Netology-DataOps\AdvancedDataMethods\ApacheSparkIntro\results.txt')