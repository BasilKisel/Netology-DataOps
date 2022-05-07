import datetime as dt
from datetime import datetime
from airflow import DAG
from airflow.models import Variable
from airflow.operators.dummy_operator import DummyOperator
# from airflow.contrib.operators.bigquery_to_gcs import BigQueryToCloudStorageOperator
# from airflow.providers.google.cloud.sensors.gcs import GCSObjectExistenceSensor

# Can't anymore import plugins through "airflow.operators". See "Changed in version 2.0:" note at https://airflow.apache.org/docs/apache-airflow/2.3.0/plugins.html
# from airflow.operators import SendEmailOperator
from airflow_operator import SendEmailOperator

# My custom data sources
from airflow.providers.postgres.operators.postgres import PostgresOperator
from airflow.providers.postgres.hooks.postgres import PostgresHook
from airflow.providers.ftp.hooks.ftp import FTPHook
from airflow.decorators import task
from io import BytesIO
import logging as log
from contextlib import closing
movies_pg_conn_id = Variable.get("PG_MOVIES_CONN_ID")
ftp_local_conn_id = Variable.get("FTP_LOCAL_CONN")
ftp_path = Variable.get("FTP_REPORT_PATH")
LOG = log.getLogger(__name__)

ARGS_CONFIG = Variable.get('ARGS_CONFIG', deserialize_json=True)
# PROJECT = str(ARGS_CONFIG['project'])
DAG_CONFIG = Variable.get('DAG_CONFIG', deserialize_json=True)
DAG_ARGS = {
    'owner': str(ARGS_CONFIG['owner']),
    'depends_on_past': False,
    'start_date': datetime(
        int(ARGS_CONFIG['start_year']),
        int(ARGS_CONFIG['start_month']),
        int(ARGS_CONFIG['start_day']),
        int(ARGS_CONFIG['start_hour']),
        int(ARGS_CONFIG['start_minute'])),
    'py_options': [],
    # 'dataflow_default_options': {
    #     'project': str(ARGS_CONFIG['project']),
    #     'region': str(ARGS_CONFIG['region'])
    # },
    }

# BQ_DATASET_ID = Variable.get('BQ_DATASET_ID') 
# BQ_TABLE_ID = Variable.get('BQ_TABLE_ID') 
# ST_BUCKET_ID = Variable.get('ST_BUCKET_ID')
CURR_DATE = str(dt.datetime.now().date())
EMAIL = Variable.get('EMAIL')


@task
def CopyReportToLocalFtp():
    LOG.info('CopyReportToLocalFtp - started')
    report_csv = ''
    pg_hook = PostgresHook(postgres_conn_id = movies_pg_conn_id)
    with closing(pg_hook.get_conn()) as conn:
        with closing(conn.cursor()) as rep_csv_cur:
            rep_csv_cur.execute(r'''SELECT E'movie_id,title,genres\n' || STRING_AGG(movie_id::TEXT || ',"' || REPLACE(title, '"', '""') || '","' || REPLACE(genres, '"', '""') || '"' , E'\n')
    	            FROM movies.movies
                ''')
            LOG.info('CopyReportToLocalFtp - finished')
            # "rownumber" doesn't work :(
            try:
                report_csv = rep_csv_cur.fetchone()[0]
                LOG.info(f'CopyReportToLocalFtp - data was found. Data sample: "{report_csv[:99]}"')
            except Exception as ex:
                report_csv = ''
                LOG.warning('CopyReportToLocalFtp - no data found')
    buf = BytesIO(bytearray(report_csv, 'UTF8'))
    FTPHook(ftp_local_conn_id).store_file(ftp_path, buf)
    LOG.info('CopyReportToLocalFtp - finished')

with DAG(dag_id=str(DAG_CONFIG['dag_id']),
         default_args=DAG_ARGS,
         max_active_runs=int(DAG_CONFIG['max_active_runs']),
         concurrency=int(DAG_CONFIG['concurrency']),
         description=str(DAG_CONFIG['description']),
         schedule_interval=dt.timedelta(days=int(DAG_CONFIG['schedule_interval'])),
         catchup=False,
         ) as dag:

    start_pipeline = DummyOperator(task_id='start-pipeline', dag=dag)

    # save_csv_report_to_gcs = BigQueryToCloudStorageOperator(
    #     task_id='save_csv_report_to_gcs',
    #     source_project_dataset_table=f'{BQ_DATASET_ID}.{BQ_TABLE_ID}',
    #     destination_cloud_storage_uris=f'gs://{ST_BUCKET_ID}/report_{CURR_DATE}.csv',
    #     export_format='text/csv',
    #     field_delimiter=',',
    #     print_header=True,
    #     bigquery_conn_id='gcp_connection',
    #     dag=dag
    # )


    #  here your homework code
    """
    check_csv_report_exist = GCSObjectExistenceSensor(
        task_id='',
        bucket='',
        object='',
        google_cloud_conn_id='',
        dag=dag
    )
    """

    # send_email = SendEmailOperator(my_operator_param='SendEmailOperator is ready to work', task_id='send-email', dag=dag)

    finish_pipeline = DummyOperator(task_id='finish-pipeline', dag=dag)

    # airflow dag graph
    # start_pipeline >> save_csv_report_to_gcs >> send_email >> finish_pipeline
    start_pipeline >> CopyReportToLocalFtp() >> finish_pipeline
