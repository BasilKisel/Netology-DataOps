﻿from pyspark.sql import SparkSession, Window
from pyspark.sql.types import StructType, StructField, StringType, DateType, DecimalType
from pyspark import StorageLevel
from datetime import date, timedelta
from pyspark.sql.functions import row_number, lag, col
from decimal import Decimal

covid_data_csv_filepath = r'C:\v.kisel\tmp\Netology.ru\Netology-DataOps\AdvancedDataMethods\ApacheSparkSqlIntro\owid-covid-data.csv'
top15_perc_2021_mar_31_filepath = r'C:\v.kisel\tmp\Netology.ru\Netology-DataOps\AdvancedDataMethods\ApacheSparkSqlIntro\top15PercOn2021Mar31.txt'
top10_new_cases_2021_mar_last_week_filepath = r'C:\v.kisel\tmp\Netology.ru\Netology-DataOps\AdvancedDataMethods\ApacheSparkSqlIntro\top10NewCasesOn2021MarLastWeek.txt'
diff_russia_2021_mar_last_week_filepath = r'C:\v.kisel\tmp\Netology.ru\Netology-DataOps\AdvancedDataMethods\ApacheSparkSqlIntro\diffRussiaOn2021MarLastWeek.txt'

cs = SparkSession.builder.appName(r'CovidStats').getOrCreate()
# I don't trust "inferSchema"
covid_data_schema = StructType([
    StructField(name = 'iso_code', dataType = StringType(), nullable = True),
    StructField(name = 'continent', dataType = StringType(), nullable = True),
    StructField(name = 'location', dataType = StringType(), nullable = True),
    StructField(name = 'date', dataType = DateType(), nullable = True),
    StructField(name = 'total_cases', dataType = DecimalType(), nullable = True),
    StructField(name = 'new_cases', dataType = DecimalType(), nullable = True),
    StructField(name = 'new_cases_smoothed', dataType = DecimalType(), nullable = True),
    StructField(name = 'total_deaths', dataType = DecimalType(), nullable = True),
    StructField(name = 'new_deaths', dataType = DecimalType(), nullable = True),
    StructField(name = 'new_deaths_smoothed', dataType = DecimalType(), nullable = True),
    StructField(name = 'total_cases_per_million', dataType = DecimalType(), nullable = True),
    StructField(name = 'new_cases_per_million', dataType = DecimalType(), nullable = True),
    StructField(name = 'new_cases_smoothed_per_million', dataType = DecimalType(), nullable = True),
    StructField(name = 'total_deaths_per_million', dataType = DecimalType(), nullable = True),
    StructField(name = 'new_deaths_per_million', dataType = DecimalType(), nullable = True),
    StructField(name = 'new_deaths_smoothed_per_million', dataType = DecimalType(), nullable = True),
    StructField(name = 'reproduction_rate', dataType = DecimalType(), nullable = True),
    StructField(name = 'icu_patients', dataType = DecimalType(), nullable = True),
    StructField(name = 'icu_patients_per_million', dataType = DecimalType(), nullable = True),
    StructField(name = 'hosp_patients', dataType = DecimalType(), nullable = True),
    StructField(name = 'hosp_patients_per_million', dataType = DecimalType(), nullable = True),
    StructField(name = 'weekly_icu_admissions', dataType = DecimalType(), nullable = True),
    StructField(name = 'weekly_icu_admissions_per_million', dataType = DecimalType(), nullable = True),
    StructField(name = 'weekly_hosp_admissions', dataType = DecimalType(), nullable = True),
    StructField(name = 'weekly_hosp_admissions_per_million', dataType = DecimalType(), nullable = True),
    StructField(name = 'new_tests', dataType = DecimalType(), nullable = True),
    StructField(name = 'total_tests', dataType = DecimalType(), nullable = True),
    StructField(name = 'total_tests_per_thousand', dataType = DecimalType(), nullable = True),
    StructField(name = 'new_tests_per_thousand', dataType = DecimalType(), nullable = True),
    StructField(name = 'new_tests_smoothed', dataType = DecimalType(), nullable = True),
    StructField(name = 'new_tests_smoothed_per_thousand', dataType = DecimalType(), nullable = True),
    StructField(name = 'positive_rate', dataType = DecimalType(), nullable = True),
    StructField(name = 'tests_per_case', dataType = DecimalType(), nullable = True),
    StructField(name = 'tests_units', dataType = DecimalType(), nullable = True),
    StructField(name = 'total_vaccinations', dataType = DecimalType(), nullable = True),
    StructField(name = 'people_vaccinated', dataType = DecimalType(), nullable = True),
    StructField(name = 'people_fully_vaccinated', dataType = DecimalType(), nullable = True),
    StructField(name = 'new_vaccinations', dataType = DecimalType(), nullable = True),
    StructField(name = 'new_vaccinations_smoothed', dataType = DecimalType(), nullable = True),
    StructField(name = 'total_vaccinations_per_hundred', dataType = DecimalType(), nullable = True),
    StructField(name = 'people_vaccinated_per_hundred', dataType = DecimalType(), nullable = True),
    StructField(name = 'people_fully_vaccinated_per_hundred', dataType = DecimalType(), nullable = True),
    StructField(name = 'new_vaccinations_smoothed_per_million', dataType = DecimalType(), nullable = True),
    StructField(name = 'stringency_index', dataType = DecimalType(), nullable = True),
    StructField(name = 'population', dataType = DecimalType(), nullable = True),
    StructField(name = 'population_density', dataType = DecimalType(), nullable = True),
    StructField(name = 'median_age', dataType = DecimalType(), nullable = True),
    StructField(name = 'aged_65_older', dataType = DecimalType(), nullable = True),
    StructField(name = 'aged_70_older', dataType = DecimalType(), nullable = True),
    StructField(name = 'gdp_per_capita', dataType = DecimalType(), nullable = True),
    StructField(name = 'extreme_poverty', dataType = DecimalType(), nullable = True),
    StructField(name = 'cardiovasc_death_rate', dataType = DecimalType(), nullable = True),
    StructField(name = 'diabetes_prevalence', dataType = DecimalType(), nullable = True),
    StructField(name = 'female_smokers', dataType = DecimalType(), nullable = True),
    StructField(name = 'male_smokers', dataType = DecimalType(), nullable = True),
    StructField(name = 'handwashing_facilities', dataType = DecimalType(), nullable = True),
    StructField(name = 'hospital_beds_per_thousand', dataType = DecimalType(), nullable = True),
    StructField(name = 'life_expectancy', dataType = DecimalType(), nullable = True),
    StructField(name = 'human_development_index', dataType = DecimalType(), nullable = True)
])
covid_df = cs.read.csv(path = covid_data_csv_filepath, schema = covid_data_schema, sep = ',', encoding = 'UTF8', header = True)
covid_df.persist(StorageLevel.MEMORY_ONLY)
# to increase filtering by date
date_col = covid_df.select('date')
date_col.persist(StorageLevel.MEMORY_ONLY)


# Выберите 15 стран с наибольшим процентом переболевших на 31 марта (в выходящем датасете необходимы колонки: iso_code, страна, процент переболевших)
top15_perc_2021_mar_31_data = covid_df \
    .where(date_col['date'] == date(2021, 3, 31)) \
    .select('iso_code', 'location', 'total_cases_per_million') \
    .where("total_cases_per_million >= 0 and iso_code not like 'OWID%'") \
    .sort(col('total_cases_per_million').desc()) \
    .limit(15) \
    .select('iso_code', col('location').alias('страна'), (col("total_cases_per_million") / 1e4).alias('процент переболевших')) \
    .write.csv(path = top15_perc_2021_mar_31_filepath, header = True)


# Top 10 стран с максимальным зафиксированным кол-вом новых случаев за последнюю неделю марта 2021
# в отсортированном порядке по убыванию (в выходящем датасете необходимы колонки: число, страна, кол-во новых случаев)
mar_31_2022_dt = date(2021, 3, 31)
mar_25_2022_dt = date(2021, 3, 25)
new_cases_2021_mar_last_week_data = covid_df \
    .where((date_col['date'] >= mar_25_2022_dt) & (date_col['date'] <= mar_31_2022_dt)) \
    .select('date', 'iso_code', 'new_cases') \
    .where("new_cases > 0 and iso_code not like 'OWID%'") \
    .withColumn('new_cases_loc_rank', row_number().over(Window().partitionBy('iso_code').orderBy(col('new_cases').desc()))) \
    .where('new_cases_loc_rank = 1') \
    .sort('new_cases', ascending = False) \
    .limit(10) \
    .select(col('date').alias('число'), col('iso_code').alias('страна'), col('new_cases').alias('кол-во новых случаев')) \
    .write.csv(path = top10_new_cases_2021_mar_last_week_filepath, header = True)


# Посчитайте изменение случаев относительно предыдущего дня в России за последнюю неделю марта 2021.
# (например: в россии вчера было 9150 , сегодня 8763, итог: -387)
# (в выходящем датасете необходимы колонки: число, кол-во новых случаев вчера, кол-во новых случаев сегодня, дельта)
## already defined:
## mar_31_2022_dt
## mar_25_2022_dt
diff_russia_2021_mar_last_week = covid_df \
    .where((date_col['date'] >= (mar_25_2022_dt - timedelta(days = 1))) & (date_col['date'] <= mar_31_2022_dt)) \
    .where("iso_code = 'RUS'") \
    .select('new_cases', 'date') \
    .withColumn('prev_day_new_cases', lag('new_cases', 1, None).over(Window().orderBy('date'))) \
    .withColumn('new_cases_delta', (col('new_cases') - col('prev_day_new_cases'))) \
    .where(col('date') >= mar_25_2022_dt) \
    .sort('date') \
    .select(col('date').alias('число'), col('prev_day_new_cases').alias('кол-во новых случаев вчера'), col('new_cases').alias('кол-во новых случаев сегодня'), col('new_cases_delta').alias('дельта')) \
    .write.csv(path = diff_russia_2021_mar_last_week_filepath, header = True)
