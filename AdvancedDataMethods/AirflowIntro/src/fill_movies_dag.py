from datetime import datetime
from airflow import DAG
from airflow.models import Variable
from airflow.providers.postgres.operators.postgres import PostgresOperator

movies_pg_conn_id = Variable.get("PG_MOVIES_CONN_ID")

with DAG(
	dag_id = 'load_movies_table',
	start_date = datetime(2022, 5, 7),
	schedule_interval = "@once",
	catchup = False
) as dag:
	create_tbl = PostgresOperator(
		task_id = "create_movies_table",
		sql = 'sql/movies_tbl_create.sql',
		postgres_conn_id = movies_pg_conn_id
	)

	ingest_data = PostgresOperator(
		task_id = "ingest_movies_data",
		sql = "sql/movies_tbl_ingest.sql",
		postgres_conn_id = movies_pg_conn_id
	)

	create_tbl >> ingest_data
